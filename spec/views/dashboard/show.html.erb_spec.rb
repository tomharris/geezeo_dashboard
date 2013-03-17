require 'spec_helper'

describe "dashboard/show" do

  before(:each) do
    accounts = assign(:accounts, [valid_account, valid_account])
    assign(:selected_account, accounts.first)
    assign(:transactions, [valid_transaction, valid_transaction, valid_transaction])
  end

  describe "account list" do

    it "renders an account list header" do
      render
      response.should have_selector('ul.nav-list li.nav-header')
    end

    it "renders an account list item for each account" do
      render
      response.should have_selector('ul.nav-list li:not(.nav-header)', count: 2)
    end
  end

  describe "transaction list" do

    it "renders a transaction list header" do
      render
      response.should have_selector('.transaction-header')
    end

    it "renders a transaction row for each transaction" do
      render
      response.should have_selector('.transaction-row', count: 3)
    end
  end
end
