class DashboardController < ApplicationController
  
  def show
    @user = current_user
    @accounts = @user.accounts
    @transactions = @accounts.first.transactions
  end
end
