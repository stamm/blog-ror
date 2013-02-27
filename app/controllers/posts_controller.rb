class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.order("created_at DESC").page(params[:page]).per(40)
  end



  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new post_time: Time.now.to_i
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    @post.post_time_string ||= l(Time.now, format: :russian)
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_url
  end


private
  def post_params
    params.require(:post).permit(
        :user_id, :content, :post_time, :short_url, :status, :title, :url,
        :tag_list, :post_time_string)
  end
end
