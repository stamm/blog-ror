class ApplicationController < ActionController::Base

  attr_accessor :title
  protect_from_forgery
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
