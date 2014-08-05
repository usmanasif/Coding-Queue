class AnswersController < ApplicationController

  before_filter :require_login, :except => [:new]
  skip_before_filter :verify_authenticity_token

  def new

    @question = Askquestion.find(params[:askquestion_id])
    @question.view_counter+=1
    @question.save
    @answer = Answer.new
    @answer_of_the_question = Answer.find_all_by_askquestion_id(params[:askquestion_id])
    @votes_on_answer = Answer.find_all_by_askquestion_id(params[:askquestion_id])
    @tags = Tag.all
    @answer_tick = @question.answers
    #@answer_votes = @question.answers.votes
    @comments = Comment.all
    @comment = Comment.new
  end

  def create
    #TODO create a before filter to check if the user is logged in.

    params[:answer][:user_id] = current_user.id if(params[:answer])

    params[:answer][:askquestion_id] = params[:askquestion_id] if(params[:askquestion_id])

    @answer = Answer.new(params[:answer])
    if @answer.save
      flash[:notice] = "Successfully answered the question."
      redirect_to new_askquestion_answer_path, :notice => "Answer has been posted"
    else
      flash[:error] = "Provide the answer."
      @question = Askquestion.find(params[:askquestion_id])
      @comments = Comment.all
      @comment = Comment.new
      @answer = Answer.new
      @answer_of_the_question = Answer.find_all_by_askquestion_id(params[:askquestion_id])
      @votes_on_answer = Answer.find_all_by_askquestion_id(params[:askquestion_id])
      @tags = Tag.all
      @answer_tick = @question.answers

      render :new
    end

  end



  def vote_up


    logger.info "=Ans_controller" * 20
    logger.info params.inspect
    logger.info current_user.inspect
    logger.info "" * 20
    logger.info "end" * 20

    @vote_up =  Answer.find(params[:id])
    @vote = @vote_up.votes.build
    @vote.user = current_user
    @vote.status = 1
    if @vote.save
      return redirect_to new_askquestion_answer_path, :notice => "Voted Up!"
    else
      #@subjects = Subject.find(:all)
      render :action => 'new'

    end
  end


  def vote_down
    @vote_down =  Answer.find(params[:id])
    @vote = @vote_down.votes.build
    @vote.user = current_user
    @vote.status = -1

    if @vote.save
      return redirect_to new_askquestion_answer_path, :notice => "Voted Down!"

    else
      #@subjects = Subject.find(:all)
      render :action => 'new'
    end

  end

  def tick_status

    @tick_status = Answer.find(params[:id])
    if (@tick_status.tick_status == 1)
      @tick_status.tick_status = nil
      if @tick_status.update_attributes(params[:answer_id])
      redirect_to new_askquestion_answer_path, :notice => "Answer DisApproved!"
    else
      render :action => 'new'
    end
    else
      @tick_status.tick_status = 1
      if @tick_status.update_attributes(params[:answer_id])
      redirect_to new_askquestion_answer_path, :notice => "Answer Approved!"
    else
      render :action => 'new'
    end
    end

  end



end
