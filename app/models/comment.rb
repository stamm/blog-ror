class Comment < ActiveRecord::Base
  attr_accessible :author, :content, :email, :ip, :post_id, :status, :url
end