require 'spec_helper'

describe SessionsController do

  describe "GET new" do

    it "should run without error" do
      get :new
      response.should be_success
    end
  end

  describe "POST create" do

    def do_post
      post :create, session: { user_id: '1', token: 'some_token' }
    end

    it "should create the session by saving the user_id and token in the session if the credentials are valid" do
      User.any_instance.stub(:valid?).and_return(true)

      do_post
      session[:user_id].should == '1'
      session[:token].should == 'some_token'
    end

    it "should not save the user_id and token in the session if the credentials are invalid" do
      User.any_instance.stub(:valid?).and_return(false)

      do_post
      session[:user_id].should be_nil
      session[:token].should be_nil
    end

    it "should redirect to the dashboard" do
      User.any_instance.stub(:valid?).and_return(true)

      do_post
      response.should redirect_to(dashboard_path)
    end
  end

  describe "DELETE destroy" do

    it "destroys the requested session" do
      delete :destroy
      session[:user_id].should be_nil
      session[:token].should be_nil
    end

    it "redirects to login screen" do
      delete :destroy
      response.should redirect_to(new_sessions_path)
    end
  end

end
