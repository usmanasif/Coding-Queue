class AnswersController < ApplicationController
  def new
    #return render :json => params
    @question = Askquestion.find(params[:askquestion_id])
    @answer = Answer.new
    @answer_of_the_question = Answer.find_all_by_askquestion_id(params[:askquestion_id])
  end

  def create
    #TODO create a before filter to check if the user is logged in.
    #return render :json => params

    params[:answer][:user_id] = current_user.id if(params[:answer])
    #params[:answer][:askquestion_id] = current_user.id if(params[:askquestion_id])
    params[:answer][:askquestion_id] = params[:askquestion_id] if(params[:askquestion_id])

    @answer = Answer.new(params[:answer])



    #@answer = current_user.askquestions.find(params[:askquestion_id]).answers.build(params[:answer][:askquestion_id])
    #@answer.user_id = current_user.id

    #@answer = current_user.askquestions.find(params[:askquestion_id]).answers.build(params[:answer][:askquestion_id])
    #@bug = current_user.projects.find(params[:project_id]).bugs.build(params[:bug])
    # @answer.user_id= current_user

    if @answer.save
      flash[:notice] = "Successfully created question."
      redirect_to root_path, :notice => "Answer  has been posted"
    else
      render :new
    end

  end

  def vote_up
    #return render :json => params
    @vote_up =  Askquestion.find(params[:askquestion_id])
      @vote_up.votes = @vote_up.votes + 1
    if @vote_up.update_attributes(params[:vote_up])
      #redirect_to :action => 'new', :id => @vote_up
      redirect_to new_askquestion_answer_path
    else
      #@subjects = Subject.find(:all)
      render :action => 'new'
    end

  end

  def vote_down
    @vote_down =  Askquestion.find(params[:askquestion_id])
    @vote_down.votes = @vote_down.votes - 1
        if @vote_down.update_attributes(params[:vote_down])
          redirect_to new_askquestion_answer_path
        else
          #@subjects = Subject.find(:all)
          render :action => 'new'
        end

  end

  def views
    #return render :json => params
    @views =  Askquestion.find(params[:askquestion_id])
    @views.view_counter = @views.view_counter + 1
    if @views.update_attributes(params[:views])
      #redirect_to :action => 'new', :id => @vote_up
      redirect_to new_askquestion_answer_path
    else
      #@subjects = Subject.find(:all)
      render :action => 'new'
    end

  end


end
