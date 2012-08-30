class ApplicationController < ActionController::Base

  attr_accessor :title
  protect_from_forgery
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  # Return a title on a per-page basis.
  def title
    base_title = "Zagirov"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
