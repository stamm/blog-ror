require "spec_helper"

describe Admin::AdminController do
  describe "routing" do
    it "routes to admin" do
      expect(get("/admin")).to route_to("admin/admin#index")
    end
  end
end
