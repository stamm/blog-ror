# encoding: utf-8
require 'spec_helper'

describe PostsController do

  subject { page }

  let!(:post) { build :post }
  let!(:user) { create :user }

  before :each do
    sign_in user
  end

  describe "GET #index" do
    it "show posts" do
      post.save
      visit posts_path
      should have_content(post.title)
    end
  end
  describe "GET #edit" do
    it "editable" do
      post.save
      visit posts_path
      click_link post.title
      current_path.should == edit_post_path(post)
      fill_in "Заголовок", with: 'Урей'
      click_button "Обновить Пост"
      post.reload
      expect(post.title).to eq('Урей')
      expect have_content('Урей')
    end
  end
  #
  #describe "GET #show" do
  #  it "assigns @post" do
  #    get :show, id: post
  #    expect(assigns(:post)).to eq post
  #  end
  #  it "render the :show view" do
  #    get :show, id: post
  #    expect(response).to render_template :show
  #  end
  #end
  #
  #
  #describe "GET #new" do
  #  it "assigns @post" do
  #    Timecop.freeze do
  #      get :new
  #      expect(assigns(:post).attributes).to eq Post.new({post_time: Time.now.to_i}).attributes
  #      expect(assigns(:post)).to be_a_new(Post)
  #    end
  #  end
  #  it "render the :new view" do
  #    get :new
  #    expect(response).to render_template :new
  #  end
  #end
  #

end