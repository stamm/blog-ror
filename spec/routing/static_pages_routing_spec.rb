require "spec_helper"

describe StaticPagesController do
  describe "routing" do
    it "routes to #about" do
      get("/about").should route_to("static_pages#about")
    end
  end
end
