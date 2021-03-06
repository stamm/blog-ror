class ApplicationController < ActionController::Base

  attr_accessor :title
  protect_from_forgery

  before_filter :authorize
  # rescue_from ActionController::UnknownFormat, :with => :not_found
  # rescue_from ActionView::MissingTemplate, :with => :not_found

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    redirect_to login_url, notice: 'Not authorized' if current_user.nil?
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

end
