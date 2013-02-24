require 'spec_helper'

describe PostsController do

  let!(:post) { build :post }
  let!(:user) { build :user }


  describe "guest access" do
    before :each do
      post.save
    end

    describe "GET #index" do
      it "needing login" do
        get :index
        expect(response).to redirect_to("/login")
      end
    end

    describe "GET #show" do
      it "needing login" do
        get :show, id: post
        expect(response).to redirect_to("/login")
      end
    end


    describe "GET #new" do
      it "needing login" do
        get :new
        expect(response).to redirect_to("/login")
      end
    end

    describe "GET #edit" do
      it "needing login" do
        get :edit, id: post
        expect(response).to redirect_to("/login")
      end
    end
  end


  describe 'admin access' do
    before :each do
      user.save
      set_user_session user
      post.save
    end

    describe "GET #index" do
      it "assigns @posts" do
        get :index
        expect(assigns(:posts)).to include post
      end
      it "render the :index view" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe "GET #show" do
      it "assigns @post" do
        get :show, id: post
        expect(assigns(:post)).to eq post
      end
      it "render the :show view" do
        get :show, id: post
        expect(response).to render_template :show
      end
    end


    describe "GET #new" do
      it "assigns @post" do
        Timecop.freeze do
          get :new
          expect(assigns(:post).attributes).to eq Post.new({post_time: Time.now.to_i}).attributes
          expect(assigns(:post)).to be_a_new(Post)
        end
      end
      it "render the :new view" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "GET #edit" do
      it "assigns @post" do
        get :edit, id: post
        expect(assigns(:post)).to eq post
      end
      it "render the :edit view" do
        get :edit, id: post
        expect(response).to render_template :edit
      end
    end
  end
end