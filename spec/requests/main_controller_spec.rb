require 'spec_helper'

describe MainController do
  let!(:post) { build :post }
  before {
    @post = post
    Post.delete_all title: @post.title
  }
  describe "GET /" do
    it 'have post title' do
      @post.save
      get '/'
      #Post.all.size.should == 1
      assigns(:posts).should include(@post)
      assigns(:title).should == "All posts"
      response.should render_template("posts")
      expect(response.body).to include(@post.title)
      expect(response.body).to include(@post.post_date)
    end
  end

end