class MainController < ApplicationController
  def article
    @post = Post.find_by_url(params[:url]) || not_found
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end
end