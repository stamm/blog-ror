require "spec_helper"

describe MainController do
  describe "routing" do

    it "routes to login" do
      expect(get("/login")).to route_to("sessions#new")
    end

    it "routes to login" do
      expect(post("/login")).to route_to("sessions#create")
    end


    it "routes to logout" do
      expect(delete("/logout")).to route_to("sessions#destroy")
    end


  end
end
