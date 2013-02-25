require 'spec_helper'

describe MainController do

  before do
    Rails.application.routes.draw do
      get "posts" => "main#posts"
      get "article" => "main#article"
    end
  end

  after do
    # Reload the routes so the rest of the app's specs still pass
    Rails.application.reload_routes!
  end

  let!(:my_post) { build :post }

  describe "GET #posts" do
    before :each do
      my_post.save
    end


    context "without tags" do
      it "assigns @posts" do
        get :posts
        expect(assigns(:posts)).to include my_post
      end
      it "assign @title" do
        get :posts
        expect(assigns(:title)).to eq "All posts"
      end
      it "have only 20 posts" do
        (1..22).each { create :post }
        get :posts
        expect(assigns(:posts)).to have(20).items
      end
    end

    context "with tags" do
      before :each do
        my_post.tag_list = 'test, yeap'
        my_post.save
      end

      it "assigns @posts" do
        get :posts, tag: 'test'
        expect(assigns(:posts)).to include my_post
      end

      it "not assigns @posts" do
        get :posts, tag: 'test1'
        expect(assigns(:posts)).not_to include my_post
      end

      it "assign @title" do
        get :posts, tag: 'test'
        expect(assigns(:title)).to eq "All posts with tag test"
      end

      it "have only 20 posts" do
        (1..21).each { create :post, tag_list: '10posts' }
        (1..10).each { create :post, tag_list: 'test1' }
        get :posts, tag: '10posts'
        expect(assigns(:posts)).to have(20).items
      end
    end

    it "have order" do
      (1..22).each { create :post, post_time: Random.rand(Time.now.to_i - 2.months.ago.to_i) + 2.months.ago.to_i }
      get :posts
      posts = assigns(:posts)
      posts.first.post_time.should be > posts.last.post_time
    end
    it "render the :index view" do
      get :posts
      expect(response).to render_template :posts
    end
  end

  describe "GET #article" do
    before :each do
      my_post.url = 'test_url'
      my_post.save
    end

    it "assign @post" do
      get :article, url: 'test_url'
      expect(assigns(:post)).to eq my_post
    end

    it "assign @post" do
      get :article, url: 'test_url'
      expect(assigns(:title)).to eq my_post.title
    end

    context "comment" do
      it "assign @comment" do
        get :article, url: 'test_url'
        expect(assigns(:comment)).to be_a_new(Comment)
      end
      it "get comment data from cookie" do
        request.cookies['comment'] = 'stamm~test@example.com'
        get :article, url: 'test_url'
        comment = assigns(:comment)
        expect(comment.author).to eq 'stamm'
        expect(comment.email).to eq 'test@example.com'
      end
    end
  end

  describe "POST #article" do
    before :each do
      my_post.url = 'test_url'
      my_post.save
    end
    context 'add comment' do
      it 'valid' do
        attr = attributes_for(:comment)
        post :article, url: 'test_url', comment: attr
        comment = assigns(:comment)
        expect(comment).to be_a(Comment)
        expect(comment.author).to eq attr[:author]
        expect(comment.email).to eq attr[:email]
        #expect(request.cookies['comment']).to eq "#{attr[:author]}~#{attr[:email]}"
        expect(response).to redirect_to(article_path(my_post.url))
        comment_db = Comment.last
        expect(comment_db.author).to eq attr[:author]
        expect(comment_db.email).to eq attr[:email]
        expect(comment_db.post).to eq my_post
        expect(my_post.comments).to eq [comment_db]
      end

      describe 'valid' do

      end
    end
  end
end