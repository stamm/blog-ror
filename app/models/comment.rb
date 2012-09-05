class Comment < ActiveRecord::Base
  attr_accessible :author, :content, :email, :url
  belongs_to :post
  validates :author, :email, :content, presence: true
end
