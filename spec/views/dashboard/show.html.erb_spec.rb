require 'spec_helper'

describe "dashboard/show" do

  before(:each) do
    assign(:accounts, [Account.new, Account.new])
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
end
