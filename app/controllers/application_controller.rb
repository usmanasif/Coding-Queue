class ApplicationController < ActionController::Base
  protect_from_forgery
  private
  def not_authenticated
    redirect_to login_url, :alert => "First log in to view this page."
  end

  #skip_before_filter :require_login, :if => :json_request?

  #protected
  #
  #def json_request?
  #  request.format.json?
  #end
end

