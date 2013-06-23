class MainController < ApplicationController

  skip_before_filter :authorize

  # GET /posts/main
  def posts
    @posts = get_posts params
    @title = get_title params
  end

  def article
    @post = Post.find_by(url: params[:url]) || not_found

    @comment = add_comment(params)

    unless @comment.new_record?
      redirect_to article_path(@post.url)
      return
    end

    @title = @post.title
  end

  def tags
    @tags = Tag.all
  end

  def search
    @search_string = params['q']
    @title = "#{t('search')}: #{@search_string}"
    ids = Post.search @search_string
    @posts = Post
      .scope_ordered_ids(ids)
      .includes!(:tags)
      .ordered
      .page(params[:page])
      .per(20)
  end

  private

  def create_comment(post)
    if post
      comment = post.comments.build(comment_params)
      status = Comment.get_status(comment.url.empty? ? :approve : :pending)
      comment.assign_attributes(ip: request.ip, status: status)
      recaptcha_opts = { model: comment, message: I18n.t(:recaptcha_error) }
      comment.save if comment.valid? && verify_recaptcha(recaptcha_opts)
      comment
    end
  end

  def comment_params
    params.require(:comment).permit(:author, :content, :email, :url)
  end

  def save_cookie(comment)
    cookies[:comment] = {
        value: comment.author + '~' + comment.email,
        expires: Time.now + 31_536_000
    }
  end

  def get_cookie(comment)
    if cookies[:comment]
      comment.author, comment.email = cookies[:comment].split '~', 2
    end
  end

  def get_posts(params)
    posts = Post.published
    posts = posts.scope_tag(params[:tag]) if params[:tag]
    posts.includes!(:tags)
    posts = posts.ordered.page(params[:page]).per(20)
    posts
  end

  def get_title(params)
    title = t('all_posts')
    title += " with tag #{params[:tag]}" if params[:tag]
    title
  end

  def add_comment(params)
    if params[:comment]
      comment = create_comment @post
      save_cookie comment
    else
      comment = Comment.new
      get_cookie comment
    end
    comment
  end
end