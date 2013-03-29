class Admin::CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  def index
    @comments = Comment.order(created_at: :desc).page(params[:page]).per(40)
  end

  def show
  end

  def new
    @comment = Comment.new
  end

  def edit
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to admin_comment_url(@comment), notice: 'Comment was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @comment.update_attributes(comment_params)
      redirect_to admin_comment_url(@comment), notice: 'Comment was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @comment.destroy

    redirect_to admin_comments_url
  end


  private
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :author, :email, :url)
  end
end
