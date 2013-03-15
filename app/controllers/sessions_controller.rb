class SessionsController < ApplicationController

  def new
  end

  def create
    session[:user_id] = params[:session][:user_id]
    session[:token] = params[:session][:token]

    redirect_to new_sessions_path
  end

  def destroy
    session.delete(:user_id)
    session.delete(:token)

    redirect_to new_sessions_path
  end
end
