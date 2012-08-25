class Post < ActiveRecord::Base
  attr_accessible :author_id, :content, :content_display, :post_time, :short_url, :status, :title, :url

  validates :title, :content, :post_time, :url, :status, presence: true
end
