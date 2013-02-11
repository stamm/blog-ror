require "spec_helper"

describe MarkitupController do
  describe "routing" do
    it { get("/markitup/preview").should route_to("markitup#preview") }
  end
end
