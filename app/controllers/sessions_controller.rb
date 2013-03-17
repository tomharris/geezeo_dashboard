class SessionsController < ApplicationController

  def new
  end

  def create
    if User.new(params[:session][:user_id], params[:session][:token]).valid?
      session[:user_id] = params[:session][:user_id]
      session[:token] = params[:session][:token]

      redirect_to dashboard_path
    else
      redirect_to new_sessions_path
    end
  end

  def destroy
    session.delete(:user_id)
    session.delete(:token)

    redirect_to new_sessions_path
  end
end
