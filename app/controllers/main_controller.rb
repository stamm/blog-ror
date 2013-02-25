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
                             per_page: 20

    respond_to do |format|
      format.html # posts.html.erb
    end
  end

  def article
    @post = Post.find_by_url(params[:url]) || not_found

    if params[:comment]
      @comment = create_comment
      save_cookie @comment
    else
      @comment = Comment.new
      get_cookie @comment
    end

    unless @comment.new_record?
      redirect_to article_path(@post.url)
      return
    end

    @title = @post.title
    respond_to do |format|
      format.html
      format.json { render json: @post }
    end
  end

  def tags
    @tags = Tag.all
  end

private

  def create_comment
    post = Post.published.find_by_url(params[:url])
    if post
      comment_params = params[:comment].merge({
          ip: request.ip,
          status: Comment::get_status(:approve)
      })
      comment = post.comments.build(comment_params)
      if comment.valid? and verify_recaptcha(model: comment, message: I18n.t(:recaptcha_error))
        comment.save
      end
      comment
    end
  end

  def save_cookie(comment)
    cookies[:comment] = {
        value: comment.author + '~' + comment.email,
        expires: Time.now + 31536000
    }
  end

  def get_cookie(comment)
    if cookies[:comment]
      comment.author, comment.email = cookies[:comment].split('~')
    end
  end

end