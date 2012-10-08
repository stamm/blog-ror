require "spec_helper"

describe MainController do
  describe "routing" do

    it "routes to login" do
      get("/login").should route_to("sessions#new")
    end

    it "routes to login" do
      post("/login").should route_to("sessions#create")
    end


    it "routes to logout" do
      delete("/logout").should route_to("sessions#destroy")
    end


  end
end
