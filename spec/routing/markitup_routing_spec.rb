require "spec_helper"

describe MarkitupController do
  describe "routing" do
    it { expect(post("/markitup/preview")).to route_to("markitup#preview") }
  end
end
