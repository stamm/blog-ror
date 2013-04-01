class MainController < ApplicationController

  skip_before_filter :authorize

  # GET /posts/main
  def posts
    #
    @posts = Post.published
    @title = t('all_posts')
    if params[:tag]
      @title += " with tag #{params[:tag]}"
      @posts = @posts.scope_tag(params[:tag])
    #else
    end
    @posts.includes!(:tags)
    @posts = @posts.ordered.page(params[:page]).per(20)
  end

  def article
    @post = Post.find_by(url: params[:url]) || not_found

    if params[:comment]
      @comment = create_comment @post
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
  end

  def tags
    @tags = Tag.all
  end

private

  def create_comment(post)
    if post
      comment = post.comments.build(comment_params)
      comment.ip = request.ip
      comment.status = Comment::get_status(:approve)
      if comment.valid? and verify_recaptcha(model: comment, message: I18n.t(:recaptcha_error))
        comment.save
      end
      comment
    end
  end

  def comment_params
    params.require(:comment).permit(:author, :content, :email, :url)
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