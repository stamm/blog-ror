require "spec_helper"

describe PostsController do
  describe "routing" do
    it "routes to tags" do
      expect(get("/tags")).to route_to("main#tags")
    end

    it "routes to posts" do
      expect(get("/")).to route_to("main#posts")
      expect(get("/posts/page/1")).to route_to("main#posts", page: "1")
      expect(get("/tag/test")).to route_to("main#posts", page: "1", tag: "test")
      expect(get("/tag/test/1")).to route_to("main#posts", page: "1", tag: "test")
    end

    it "route to post" do
      expect(get("/abra")).to route_to(controller: "main" , action: "article", url: "abra")
    end
  end
end
