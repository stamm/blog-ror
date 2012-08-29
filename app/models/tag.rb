class Tag < ActiveRecord::Base
  attr_accessible :frequency, :name

  has_many :post_tags
  has_many :posts, through: :post_tags
end
