class AskquestionsController < ApplicationController

  before_filter :require_login, only: [:create]

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

    @askquestions = Askquestion.page(params[:page]).per_page(6)
    #@askquestions = Askquestion.paginate(:page => params[:page], :per_page => 3)

    #@askquestion = Askquestion.find(params[:id])----------------------  gillani before pagination
    @count=Askquestion.count
  end

end

   def vote_up
      #return render :json => params
      @vote_up =  Askquestion.find(params[:askquestion_id])
      @vote_up.votes = @vote_up.votes + 1
      if @vote_up.update_attributes(params[:vote_up])
        #redirect_to :action => 'new', :id => @vote_up
        return render :json => params
        #redirect_to new_askquestion_answer_path
      else
        #@subjects = Subject.find(:all)
        render :action => 'new'
      end

  end


#def vote_down
#  @vote_down =  Askquestion.find(params[:askquestion_id])
#  @vote_down.votes = @vote_down.votes - 1
#  if @vote_down.update_attributes(params[:vote_down])
#    redirect_to new_askquestion_answer_path
#  else
#    #@subjects = Subject.find(:all)
#    render :action => 'new'
#  end
#
#end
#
#def views
#
#  @views =  Askquestion.find(params[:askquestion_id])
#  @views.view_counter = @views.view_counter + 1
#  if @views.update_attributes(params[:views])
#    #redirect_to :action => 'new', :id => @vote_up
#    redirect_to new_askquestion_answer_path
#  else
#    #@subjects = Subject.find(:all)
#    render :action => 'new'
#  end
#
#end