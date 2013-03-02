require 'spec_helper'

describe Admin::PostsController do

  #let!(:my_post) { build :post }
  let!(:user) { build :user }


  describe "guest access" do
    before :each do
      @my_post = create :post
    end


    %w{index new}.each do |calltype|
      describe "GET ##{calltype}" do
        it "needing login" do
          get calltype
          expect(response).to redirect_to(login_path)
        end
      end
    end

    %w{show edit}.each do |calltype|
      describe "GET ##{calltype}" do
        it "needing login" do
          get calltype, id: @my_post
          expect(response).to redirect_to(login_path)
        end
      end
    end
  end


  describe 'admin access' do
    before :each do
      user.save
      set_user_session user
      @my_post = create :post
    end

    describe "GET #index" do
      it "assigns @posts" do
        get :index
        expect(assigns(:posts)).to include @my_post
      end
      it "render the :index view" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe "GET #show" do
      it "assigns @post" do
        get :show, id: @my_post
        expect(assigns(:post)).to eq @my_post
      end
      it "render the :show view" do
        get :show, id: @my_post
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

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new @my_post in the database" do expect{
          attributes = attributes_for(:post)
          post :create, post: attributes
        }.to change(Post, :count).by(1)
        end
        it "redirects to the home page" do
          attributes = attributes_for(:post)
          post :create, post: attributes
          expect(response).to redirect_to admin_post_path(Post.last)
          end
      end

      context "with invalid attributes" do
        it "does not save the new post in the database" do
          expect{
            post :create,
                 post: attributes_for(:invalid_post)
          }.to_not change(Post, :count)
        end
        it "re-renders the :new template" do
          post :create,
            post: attributes_for(:invalid_post)
          expect(response).to render_template :new
        end
      end
    end



    describe "GET #edit" do
      it "assigns @post" do
        get :edit, id: @my_post
        expect(assigns(:post)).to eq @my_post
      end
      it "render the :edit view" do
        get :edit, id: @my_post
        expect(response).to render_template :edit
      end
    end

    describe'PUT #update'do
      before :each do
        @post = create(:post, title: "My good post")
      end

      it "locates the requested @post" do
        put :update, id: @post, post: attributes_for(:post)
        expect(assigns(:post)).to eq(@post)
      end

      context "valid attributes" do
        it "changes @post's attributes" do
          put :update, id: @post,
            post: attributes_for(:post,
              content: "this is the text")
          @post.reload
          expect(@post.content).to eq("this is the text")
        end
        it "redirects to the updated post" do
          put :update, id: @post, post: attributes_for(:post)
          response.should redirect_to admin_post_path(@post)
          expect(response).to redirect_to admin_post_path(@post)
          end
      end

      context "invalid attributes" do
        it "does not change @post's attributes" do
          put :update, id: @post,
            post: attributes_for(:post,
              title: "None of your business",
              url: nil)
          @post.reload
          expect(@post.title).not_to eq("None of your business")
          expect(@post.url).not_to be_nil
        end
        it "re-renders the edit method" do
          put :update, id: @post, post: attributes_for(:invalid_post)
          expect(response).to render_template :edit
        end
      end
    end





    describe'DELETE #destroy' do
      it "deletes the post" do expect{
          delete :destroy, id: @my_post
        }.to change(Post,:count).by(-1)
      end
      it "redirects to post#index" do
        delete :destroy, id: @my_post
        expect(response).to redirect_to admin_posts_url
      end
    end
  end
end