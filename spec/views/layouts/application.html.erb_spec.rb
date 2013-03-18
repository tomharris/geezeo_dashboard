require 'spec_helper'

describe "layouts/application" do

  before(:each) do
    view.stub!(:signed_in?).and_return(true)
  end

  it "should have a logout button when signed-in" do
    render
    response.should have_selector(".sign-out-bar a[href='#{sign_out_path}']")
  end

  it "should not have a logout button when not signed-in" do
    view.stub!(:signed_in?).and_return(false)
    render
    response.should_not have_selector(".sign-out-bar a[href='#{sign_out_path}']")
  end

  it "should show a flash message if one was set" do
    flash['warning'] = 'Test message!'
    render
    response.should have_selector(".alert", text: 'Test message!')
  end
end
