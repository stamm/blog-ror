class Post < ActiveRecord::Base
  attr_accessible :author_id, :content, :content_display, :post_time, :short_url, :status, :title, :url
end
