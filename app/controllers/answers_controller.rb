class AnswersController < ApplicationController

  before_filter :require_login, :except => [:new]
  skip_before_filter :verify_authenticity_token

  def new

    @question = Askquestion.find(params[:askquestion_id])
    @answer = Answer.new
    @answer_of_the_question = Answer.find_all_by_askquestion_id(params[:askquestion_id])
    @votes_on_answer = Answer.find_all_by_askquestion_id(params[:askquestion_id])

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
      flash[:notice] = "Successfully created question."
      redirect_to root_path, :notice => "Answer  has been posted"
    else
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
    ############################################
    @question = Askquestion.find(params[:askquestion_id])
    @answer = Answer.new
    @answer_of_question = Answer.find_all_by_askquestion_id(params[:askquestion_id])
    @vote_answer = @answer.vote_calculate(@question)
    @comments = Comment.all
    @comment = Comment.new
    ############################################
    if @vote.save
      return render :partial => 'answers/answers_of_question', :locals => { :sum_status => @vote_up.votes.sum(:status), :vote_answer => @vote_answer }
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
    ############################################
    @question = Askquestion.find(params[:askquestion_id])
    @answer = Answer.new
    @answer_of_question = Answer.find_all_by_askquestion_id(params[:askquestion_id])
    @vote_answer = @answer.vote_calculate(@question)
    @comments = Comment.all
    @comment = Comment.new
    ############################################
    if @vote.save
      return render :partial => 'answers/answers_of_question', :locals => { :sum_status => @vote_down.votes.sum(:status), :vote_answer => @vote_answer }
      #return render :json => @vote_down.votes.sum(:status)

    else
      render :action => 'new'
    end

  end

  def tick_status


    @tick_status = Answer.find(params[:id])
    @tick_status.tick_status = 1

    ##############Start of additional work ##############################
    @question = Askquestion.find(params[:askquestion_id])
    @answer = Answer.new
    @vote_answer = @answer.vote_calculate(@question)
    @comments = Comment.all
    @comment = Comment.new
    ################End of ############################

    if @tick_status.update_attributes(params[:answer_id])
      ############################################
      @answer_of_question = Answer.find_all_by_askquestion_id(params[:askquestion_id])
      ############################################

      return render :partial => 'answers/answers_of_question',   :locals => { :vote_answer => @vote_answer }

      #redirect_to new_askquestion_answer_path
    else
      render :action => 'new'
    end

  end



end
