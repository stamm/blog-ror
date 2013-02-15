require 'spec_helper'

describe PostsController do

  let!(:post) { build :post }
  before {
    @post = post
    Post.delete_all title: @post.title
  }

  let!(:user) { build :user }
  before {
    @user = user
    User.delete_all name: @user.name
  }

  describe "GET index" do
    it "needing login" do
      get :index
      expect(response).to redirect_to("/login")
    end

    it "assigns @posts" do
      @user.save
      request.session[:user_id] = @user.id
      request.session[:user_id].should == @user.id
      @post.save
      get :index
      assigns(:posts).should include(@post)
      response.should render_template("index")
    end
  end

  describe "GET show" do
    it "needing login" do
      @post.save
      get :show, { id: @post.id }
      expect(response).to redirect_to("/login")
    end

    it "assigns @post" do
      @user.save
      request.session[:user_id] = @user.id
      request.session[:user_id].should == @user.id
      @post.save
      get :show, { id: @post.id}
      assigns(:post).should == @post
      response.should render_template("show")
    end
  end


  describe "GET  new" do
    it "needing login" do
      get :new
      expect(response).to redirect_to("/login")
    end

    it "assigns @post" do
      @user.save
      request.session[:user_id] = @user.id
      request.session[:user_id].should == @user.id
      Timecop.freeze do
        get :new
        assigns(:post).attributes.should == Post.new({post_time: Time.now.to_i}).attributes
      end
      response.should render_template("new")
    end
  end

  describe "GET edit" do
    it "needing login" do
      @post.save
      get :edit, { id: @post.id }
      expect(response).to redirect_to("/login")
    end

    it "assigns @post" do
      @user.save
      request.session[:user_id] = @user.id
      request.session[:user_id].should == @user.id
      @post.save
      get :edit, { id: @post.id}
      assigns(:post).should == @post
      response.should render_template("edit")
    end
  end

end