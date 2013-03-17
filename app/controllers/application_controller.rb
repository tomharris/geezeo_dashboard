class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected
  
  def current_user
    @_current_user ||= User.new(session[:user_id], session[:token])
  end
end
