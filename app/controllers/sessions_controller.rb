class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def new

  end

  def create

    ['{ %%%% -- '*33, session, request.cookie_jar['_codingstack_session'], '% -- '*33].each{|x| logger.debug x.inspect}

    user = login(params[:email], params[:password], params[:remember_me])

    ['{ %%%% -- '*33, session, request.cookie_jar['_codingstack_session'], '% -- '*33].each{|x| logger.debug x.inspect}

    if user
      logger.info '='*80
      logger.info current_user.inspect
      logger.info '='*80
      #return render :json => current_user.inspect


      #respond_to do |format|
      #  #create.js
      #  #format.html {redirect_to root_path, :notice => "Logged in!"}
      #  #format.html {render text: 'redirect_to root_path, :notice => "Logged in!"'}
      #  format.html {redirect_to root_path, :notice => "Logged in!"}
      #  #format.js
      #end
      redirect_to root_path, :notice => "Logged in!"
    #  format.js
    else
      #return render :json => 'ab'
      redirect_to :back, :notice => "Email or password was invalid Please enter again."
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => "Logged out!"
  end
end







#ask question and login logic
#def create
#  user = login(params[:email], params[:password], params[:remember_me])
#  if user
#    if askquestion.blank?
#      #return render :json => askquestion
#      redirect_to root_path, :notice => "Logged in!"
#
#
#    else
#      askquestion = Askquestion.new
#      askquestion = current_user.askquestions.build(params[:askquestion])
#      #return render :json => @askquestion
#      askquestion.save
#      redirect_to root_path, :notice => "Logged innnnnnnnnnnnnn!"
#    end
#  else
#    redirect_to :back, :notice => "Email or password was invalid Please enter agaian."
#  end
#end