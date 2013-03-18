require "spec_helper"

describe SessionsController do
  describe "routing" do

    it "routes to #new" do
      get("/sessions/new").should route_to("sessions#new")
    end

    it "routes to #create" do
      post("/sessions").should route_to("sessions#create")
    end

    it "routes to #destroy" do
      delete("/sessions").should route_to("sessions#destroy")
    end

    it "routes to #destroy" do
      get("/sign_out").should route_to("sessions#destroy")
    end
  end
end
