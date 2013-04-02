class Admin::PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  # GET /posts
  def index
    @posts = Post.order(created_at: :desc).page(params[:page]).per(40)
  end



  # GET /posts/1
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new post_time: Time.now.to_i
    5.times { @post.assets.build }
  end

  # GET /posts/1/edit
  def edit
    5.times { @post.assets.build }
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    @post.post_time_string ||= l(Time.now, format: :russian)
    if @post.save
      redirect_to admin_post_url(@post), notice: 'Post was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /posts/1
  def update
    if @post.update_attributes(post_params)
      redirect_to admin_post_url(@post), notice: 'Post was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy

    redirect_to admin_posts_url
  end


private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(
        :user_id, :content, :post_time, :short_url, :status, :title, :url,
        :tag_list, :post_time_string)
  end
end
