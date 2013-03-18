require 'spec_helper'

describe "layouts/application" do

  it "should have a logout button when signed-in" do
    view.stub!(:signed_in?).and_return(true)
    render
    response.should have_selector(".sign-out-bar a[href='#{sign_out_path}']")
  end

  it "should not have a logout button when not signed-in" do
    view.stub!(:signed_in?).and_return(false)
    render
    response.should_not have_selector(".sign-out-bar a[href='#{sign_out_path}']")
  end
end
