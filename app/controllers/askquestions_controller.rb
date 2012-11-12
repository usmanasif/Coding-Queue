class AskquestionsController < ApplicationController

  before_filter :require_login, :except => [:index,:new]

  skip_before_filter :verify_authenticity_token

  def new

    ['{ %%%% -- '*33, Rails.configuration.session_options[:key], Rails.configuration.secret_token, request.host, session, request.cookie_jar['_codingstack_session'], '% -- '*33].each{|x| logger.debug x.inspect}
    request.cookie_jar.each{|x, y| logger.debug x + ' ... ' + y.inspect}

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



    if @askquestion.save
      #return render :json=> params
      flash[:notice] = "Successfully created question."
      redirect_to askquestions_path, :notice => "new question has been created"
    else
      #return render :json=> params
      render :new
    end

  end

  def index

    @askquestions = Askquestion.page(params[:page]).per_page(4)
    #@askquestions = Askquestion.paginate(:page => params[:page], :per_page => 3)

    #@askquestion = Askquestion.find(params[:id])----------------------  gillani before pagination
    #@count=Askquestion.count
  end



   def vote_up

     #logger.info "=" * 20
     #logger.info params.inspect
     #logger.info "end" * 20


      @vote_up =  Askquestion.find(params[:id])
      @vote = @vote_up.votes.build
      @vote.user = current_user
      @vote.status = 1
      if @vote.save
        return render :json => @vote_up.votes.sum(:status)
      else
        #@subjects = Subject.find(:all)
        render :action => 'new'

      end

  end


    def vote_down

      @vote_down =  Askquestion.find(params[:id])
      @vote = @vote_down.votes.build
      @vote.user = current_user
      @vote.status = -1

      if @vote.save

        return render :json => @vote_down.votes.sum(:status)

      else
        #@subjects = Subject.find(:all)
        render :action => 'new'
      end

    end

  def views

    @views =  Askquestion.find(params[:id])
    @views.view_counter = @views.view_counter + 1
    if @views.update_attributes(params[:views])

      return render :json=> @views.view_counter
    else

      render :action => 'new'
    end

  end

end