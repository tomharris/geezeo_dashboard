# encoding: UTF-8

require 'spec_helper'

describe "dashboard/show" do

  before(:each) do
    @accounts = assign(:accounts, [valid_account, valid_account])
    @selected_account = assign(:selected_account, @accounts.first)
    assign(:page, 1)

    @transaction_collection = [valid_transaction, valid_transaction, valid_transaction]
    @transaction_collection.stub!(:total_pages).and_return(2)
    assign(:transactions, @transaction_collection)
  end

  describe "account list" do

    it "renders an account list header" do
      render
      response.should have_selector('ul.nav-list li.nav-header')
    end

    it "renders an account list item for each account" do
      render
      response.should have_selector('ul.nav-list li.account', count: 2)
    end

    it "should set the id of the account menu item to the id off the account" do
      render
      @accounts.each do |account|
        response.should have_selector("ul.nav-list li##{account.id}")
      end
    end

    it "should add the 'active' class to the selected account" do
      render
      response.should have_selector("ul.nav-list li.active a[href='#{dashboard_path('account_id' => @selected_account.id)}']")
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

    it "should have pagination" do
      render
      response.should have_selector('.pagination ul li', count: 4) # 2 pages plus 'next' and 'previous'
    end

    it "should have an 'up arrow' for a credit transaction" do
      @transaction_collection.first.stub!(:credit?).and_return(true)
      render
      response.should have_selector('.transaction-row .badge.badge-success', text: '↑')
    end

    it "should have a 'down arrow' for a debit transaction" do
      @transaction_collection.first.stub!(:debit?).and_return(true)
      render
      response.should have_selector('.transaction-row .badge.badge-warning', text: '↓')
    end
  end
end
