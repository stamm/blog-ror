require "spec_helper"

describe AjaxController do
  describe "routing" do
    it { get("/ajax/markitup").should route_to("ajax#markitup") }

  end
end
