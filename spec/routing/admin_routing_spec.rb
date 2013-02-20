require "spec_helper"

describe AdminController do
  describe "routing" do
    it "routes to admin" do
      expect(get("/admin")).to route_to("admin#index")
    end
  end
end
