require "spec_helper"

describe MarkitupController do
  describe "routing" do
    it { expect(get("/markitup/preview")).to route_to("markitup#preview") }
  end
end
