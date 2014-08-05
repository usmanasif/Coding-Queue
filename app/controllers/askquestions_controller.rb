class AskquestionsController < ApplicationController

  before_filter :require_login, :except => [:index,:new]

  skip_before_filter :verify_authenticity_token

  def new

  # ['{ %%%% -- '*33, Rails.configuration.session_options[:key], Rails.configuration.secret_token, request.host, session, request.cookie_jar['_codingstack_session'], '% -- '*33].each{|x| logger.debug x.inspect}
  # request.cookie_jar.each{|x, y| logger.debug x + ' ... ' + y.inspect}

    @askquestion = Askquestion.new

  end

  def unanswer
    @askquestions = Askquestion.page(params[:page]).per_page(6).order('created_at DESC')
  end

  def tagged
    @askquestions = Askquestion.page(params[:page]).per_page(6).order('created_at DESC')
    @tag = Tag.find(params[:id])

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
    # @temp = 0
    

        # if @temp==0
        #   @tag= Tag.new
        #   @tag.counter=1
        #   @tag.askquestion_tags= @askquestion.tag
        # en
    #     @askquestion.tag.each do |q|
           # # @tag.askquestion_tags= @askquestion.tag
    #    end
#        break

      
# ##        create(@tag)
#       end
#     end
       
    # @tag=Tag.all
    # @tag.each do |tag|
    #   tag.counter += 1
    #   tag.save
    # end

      














      # @tag=Tag.all
      # @tag.each do |tag|
      #   if tag.name == @askquestion.tag.split
      #     tag.counter=tag.counter+1
      #     tag.save
      #   end
      # end


    if @askquestion.save
      #return render :json=> params
      flash[:notice] = "Successfully created question."
      redirect_to askquestions_path, :notice => "New question has been created"
    else
      #return render :json=> params
      render :new
    end

  end

  def index
    @tags = Tag.all
    @recent_users = User.order('created_at DESC').limit(5).all
    #return render :json => params
    if(params[:search]).present?
    @askquestions = Askquestion.search(params[:search], order: :title,:page => params[:page], :per_page => 6, field_weights: {title: 20, description: 10, tag: 5})

    else

      @askquestions = Askquestion.page(params[:page]).per_page(6).order('created_at DESC')

      #@askquestions = Askquestion.paginate(:page => params[:page], :per_page => 5)

    end


    #@askquestions = Askquestion.search(params)


    #@askquestions = Askquestion.page(params[:page]).per_page(6)



    #@askquestions = Askquestion.paginate(:page => params[:page], :per_page => 5)



    #@askquestion = Askquestion.find(params[:id])----------------------  gillani before pagination
    #@count=Askquestion.count
  end




  def vote_down

     #logger.info "=" * 20
     #logger.info params.inspect
     #logger.info "end" * 20


      @vote_down =  Askquestion.find(params[:id])
      @vote = @vote_down.votes.build
      @vote.user = current_user
      @vote.status = -1
      if @vote.save
        return redirect_to :back, :notice => "Voted Down!"
      else
        #@subjects = Subject.find(:all)
        render :action => 'new'

      end

  end
def vote_up

     #logger.info "=" * 20
     #logger.info params.inspect
     #logger.info "end" * 20


      @vote_down =  Askquestion.find(params[:id])
      @vote = @vote_down.votes.build
      @vote.user = current_user
      @vote.status = 1
      if @vote.save
        return redirect_to :back, :notice => "Voted Up!"
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



end
