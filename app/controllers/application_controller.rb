class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :signed_in?
  
  protected
  
  def current_user
    @_current_user ||= User.new(session[:user_id], session[:token])
  end
  
  def signed_in?
    session[:user_id] and session[:token]
  end
end
