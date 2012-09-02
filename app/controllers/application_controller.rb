class ApplicationController < ActionController::Base

  attr_accessor :title
  protect_from_forgery

  before_filter :authorize

  def authorize
    unless User.find_by_id(session[:user_id])
      redirect_to login_url, notice: "Please, go auth"
    end
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

end
