class AskquestionsController < ApplicationController

  # before_filter :require_login, :except => [:index,:new]

  skip_before_filter :verify_authenticity_token

  def new

    ['{ %%%% -- '*33, Rails.configuration.session_options[:key], Rails.configuration.secret_token, request.host, session, request.cookie_jar['_codingstack_session'], '% -- '*33].each{|x| logger.debug x.inspect}
    request.cookie_jar.each{|x, y| logger.debug x + ' ... ' + y.inspect}
    #return render :json => params
    @askquestion = Askquestion.new

  end

  def create
    #['% -- '*33, session, '% -- '*33].each{|x| logger.debug x.inspect}
    #
    #if !logged_in?
    #  session[:return_to_url] = request.url if Config.save_return_to_url
    #  self.send(Config.not_authenticated_action)
    #  return
    #end
    #
    #['% -- '*33, session, '% -- '*33].each{|x| logger.debug x.inspect}

    #return render :json => params
    #return render :json => params
    #return render :json => session
    @askquestion = current_user.askquestions.build(params[:askquestion])
    # return render :json => params

    # will be use in future
    #    @tag=Tag.all
    #    @tag.each do |question|
    #      if @askquestion.tag==question.askquestion_tag
    #        question.counter=question.counter+1
    #
    #        break
    #
    #      else
    #        @tag= Tag.new
    #        @tag.counter=1
    #        @tag.askquestion_tag= @askquestion.tag
    ##        create(@tag)
    #      end
    #    end

    if(current_user.present?)
      if @askquestion.save
        #return render :json=> params
        flash[:notice] = "Successfully created question."
        redirect_to askquestions_path, :notice => "new question has been created"
         rating = Rating.where("name_event = 'question_posted'")
         question_rating = rating && rating.first.points
         
        current_user.rating += question_rating
        current_user.save
      else
        #return render :json=> params
        render :new
      end
    else
      render :partial => 'sessions/new'
    end
  end

  def index

    if(params[:search]).present?
      @askquestions = Askquestion.search(params[:search], order: :title, :page => params[:page], :per_page => 6, :star => true,:ignore_errors => true, field_weights: {title: 20, description: 10, tag: 5})
    else
      @askquestions = Askquestion.page(params[:page]).per_page(6)
    end


  end



   def vote_up

      @vote_up =  Askquestion.find(params[:id])

      @vote = Vote.where("user_id = ? AND votable_id = ? AND votable_type = ?", current_user,  @vote_up, 'Askquestion').first
      puts "*"*80
      puts @vote
      puts "*"*80
      @vote = @vote_up.votes.build if @vote.blank?

      @vote.user = current_user
      @vote.status = 1
      if @vote.save
        #user rating
        vote_rating = Rating.where("name_event = 'vote_posted'").first.points
        puts "-"*80
        puts vote_rating
        puts "-"*80
        current_user.rating += vote_rating
        current_user.save
        return render :json => @vote_up.votes.sum(:status)
        #return render :json => @vote
        
      else
        #@subjects = Subject.find(:all)
        render :action => 'new'
      end
   end



    def vote_down

      @vote_down =  Askquestion.find(params[:id])
      @vote = Vote.where("user_id = ? AND votable_id = ? AND votable_type = ?", current_user,  @vote_down, 'Askquestion').first
      @vote = @vote_down.votes.build if @vote.blank?
      #@vote = @vote_down.votes.build
      @vote.user = current_user
      @vote.status = -1

      if @vote.save
        #user rating
        vote_rating = Rating.where("name_event = 'vote_posted'").first.points
         
        current_user.rating += vote_rating
        current_user.save
        
        return render :json => @vote_down.votes.sum(:status)

      else
        #@subjects = Subject.find(:all)
        render :action => 'new'
      end

    end

  #def views
  #
  #  @views =  Askquestion.find(params[:id])
  #  @views.view_counter = @views.view_counter + 1
  #  if @views.update_attributes(params[:views])
  #
  #    return render :json=> @views.view_counter
  #  else
  #
  #    render :action => 'new'
  #  end
  #
  #end

  def  unanswered_questions
    @unanswered_question = Askquestion.all
    #@test = unanswered_questions
  end

  def favourite
    Favourite.create!(:user_id => current_user.id, :askquestion_id => params[:id])
    flash[:notice] = "marked as favourite!"
    return render :text => 'success'
  end

  def inappropriate
    Inappropriate.create!(:user_id => current_user.id, :entity_id => params[:id], :entity => "Askquestion")
    flash[:notice] = "marked as inappropriate!"
    return render :text => 'success'
  end

  def watch
    Watch.create!(:user_id => current_user.id, :askquestion_id => params[:id])
    flash[:notice] = "Watch activated!"
    return render :text => 'success'
  end
end
