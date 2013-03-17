class DashboardController < ApplicationController
  
  def show
    @user = current_user
    @accounts = @user.accounts
    @selected_account = @accounts.first
    @transactions = @selected_account.transactions
  end
end
