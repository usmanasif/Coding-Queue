class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create

    @user = User.new(params[:user])
    if @user.save
      login(params[:user][:email], params[:user][:password], params[:remeber_me])
      #respond_to do |format|
      #  format.html { redirect_to askquestions_new_path, :notice => "Signed up!" }
      #  format.json { render json: {success: true, user_id: current_user.id } }
      #end
      return render :partial => 'sessions/change_user_status', :locals => { :user => @user }
    else
      return render :text => "false"
      #respond_to do |format|
      #  format.html { render :new }
      #  format.json { render json: {success: false} }
      #end
    end
  end

  def index
    @users = User.page(params[:page]).per_page(10)
  end

  def show
    @user = User.find(params[:id])
  end

end

