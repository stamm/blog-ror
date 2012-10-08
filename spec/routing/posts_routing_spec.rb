require "spec_helper"

describe PostsController do
  describe "routing" do
    it "routes to tags" do
      get("/tags").should route_to("main#tags")
    end

    it "routes to posts" do
      get("/").should route_to("main#posts", page: 1)
      get("/posts/page/1").should route_to("main#posts", page: "1")
      get("/tag/test").should route_to("main#posts", page: 1, tag: "test")
      get("/tag/test/1").should route_to("main#posts", page: "1", tag: "test")
    end


    it "route to post" do
      get("/abra").should route_to(controller: "main" , action: "article", url: "abra")
    end


  end
end
