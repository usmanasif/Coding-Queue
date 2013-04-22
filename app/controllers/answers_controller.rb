class AnswersController < ApplicationController

  before_filter :require_login, :except => [:new]
  skip_before_filter :verify_authenticity_token
  def new

    @question = Askquestion.find(params[:askquestion_id])
    @answer = Answer.new
    # @answer_of_question = Answer.find_all_by_askquestion_id(params[:askquestion_id])


    @votes_on_answer = Answer.find_all_by_askquestion_id(params[:askquestion_id])

    @answer_tick = @question.answers
    #@answer_votes = @question.answers.votes
    @comments = Comment.all
    @comment = Comment.new
  end

  def create
    #TODO create a before filter to check if the user is logged in.
    #return render :json => params
    @question = Askquestion.find(params[:askquestion_id])
    @answer_of_the_question = Answer.find_all_by_askquestion_id(params[:askquestion_id])
    @comments = Comment.all
    @comment = Comment.new

    params[:answer][:user_id] = current_user.id if(params[:answer])

    params[:answer][:askquestion_id] = params[:askquestion_id] if(params[:askquestion_id])
   
    @answer = Answer.new(params[:answer])
    if @answer.save
      flash[:notice] = "Successfully created question."
      #redirect_to root_path, :notice => "Answer  has been posted"

      #user rating on new answer post
        answer_rating = Rating.where("name_event = 'answer_posted'").first.points
         
        current_user.rating += answer_rating
        current_user.save

      redirect_to new_askquestion_answer_path, :notice => "Answer  has been posted"
      # Send emails in watched question
      send_watched_emails(@answer.askquestion)
    else
      render :new
    end
  end

  def send_watched_emails(question)
    question.watches.each do |watch|
      # Send emails in watched question as delayed task
       @sendmail = UserMailer.delay.send_update(watch.user, question.id)
      
    end
  end

  def vote_up
    @vote_up =  Answer.find(params[:id])
    @vote = Vote.where("user_id = ? AND votable_id = ? AND votable_type = ?", current_user,  @vote_up, 'Answer').first
    @vote = @vote_up.votes.build if @vote.blank?
    @vote.user = current_user
    @vote.status = 1
    ############################################
    @question = Askquestion.find(params[:askquestion_id])
    @answer = Answer.find(params[:id])
    @answer_of_question = @answer.vote_calculate(params[:askquestion_id])
    @vote_answer = @answer.vote_calculate(@question)
    @comments = Comment.all
    @comment = Comment.new
    ############################################
    if @vote.save
      #user rating
        vote_rating = Rating.where("name_event = 'vote_posted'").first.points
         
        current_user.rating += vote_rating
        current_user.save
      
      #return render :json => @vote_up.votes.sum(:status)
      #return render :partial => 'answers/answers_of_question', :locals => { :sum_status => @vote_up.votes.sum(:status), :vote_answer => @vote_answer }
      return render :json => @vote_up.votes.sum(:status)
    else
      #@subjects = Subject.find(:all)
      render :action => 'new'
    end
  end

  def vote_down

    @vote_down =  Answer.find(params[:id])
    @vote = Vote.where("user_id = ? AND votable_id = ? AND votable_type = ?", current_user,  @vote_down, 'Answer').first
    @vote = @vote_down.votes.build if @vote.blank?

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
      #user rating
        vote_rating = Rating.where("name_event = 'vote_posted'").first.points
         
        current_user.rating += vote_rating
        current_user.save
      #return render :partial => 'answers/answers_of_question', :locals => { :sum_status => @vote_down.votes.sum(:status), :vote_answer => @vote_answer }
      return render :json => @vote_down.votes.sum(:status)
    else
      render :action => 'new'
    end
  end

  def tick_status


    @tick_status = Answer.find(params[:id])
    @tick_status.tick_status = 1

    ##############Start of additional work ##############################
    # @question = Askquestion.find(params[:askquestion_id])
    @answer =  Answer.find(params[:id])
    @answer_of_question  =  @tick_status.vote_calculate(params[:askquestion_id])
    # @comments = Comment.all
    # @comment = Comment.new
    ################End of ############################

    # if @tick_status.update_attributes(params[:id])
      ############################################
      # @answer_of_question = Answer.find_all_by_askquestion_id(params[:askquestion_id])
      ############################################
      #user rating
        solution_rating = Rating.where("name_event = 'solution_posted'").first.points
         
        @tick_status.user.rating += solution_rating
        @tick_status.user.save

      return render :partial => 'answers/answers_of_question'

    #   #redirect_to new_askquestion_answer_path
    # else
    #   render :action => 'new'
    # end

  end

  def inappropriate
    Inappropriate.create!(:user_id => current_user.id, :entity_id => params[:id], :entity => "Answer")
    flash[:notice] = "marked as inappropriate!"
    return render :text => 'success'
  end

end