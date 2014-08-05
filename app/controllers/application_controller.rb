class ApplicationController < ActionController::Base
  protect_from_forgery
  private
  def not_authenticated
    redirect_to login_url, :notice => "First log in to view this page."
  end


  def root_url
    cookies[:user_name] = "david"
    flash[:notice] = @email
  end

  #skip_before_filter :require_login, :if => :json_request?

  #protected
  #
  #def json_request?
  #  request.format.json?
  #end
end

