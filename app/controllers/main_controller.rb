class MainController < ApplicationController

  skip_before_filter :authorize

  # GET /posts/main
  def posts
    @posts = Post.published
    @title = 'All posts'
    if params[:tag]
      @title += " with tag #{params[:tag]}"
      @posts = @posts.scope_tag(params[:tag])
    end
    @posts = @posts.paginate page: params[:page], order: 'post_time desc',
                             per_page: 2

    respond_to do |format|
      format.html # main.html.erb
    end
  end

  def article
    @post = Post.find_by_url(params[:url]) || not_found
    @title = @post.title
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end
end