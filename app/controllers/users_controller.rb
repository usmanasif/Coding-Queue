class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create

    @user = User.new(params[:user])
    if @user.save
      login(params[:user][:email], params[:user][:password], params[:remeber_me])
      respond_to do |format|
        format.html { redirect_to askquestions_new_path, :notice => "Signed up!" }
        format.json { render json: {success: true, user_id: current_user.id } }
      end
    else
      return render :json => params
      respond_to do |format|
        format.html { render :new }
        format.json { render json: {success: false} }
      end
    end
  end

end

