# == Schema Information
#
# Table name: tags
#
#  id        :integer          not null, primary key
#  name      :string(255)      not null
#  frequency :integer          default(0), not null
#

class Tag < ActiveRecord::Base
  attr_accessible :frequency, :name

  has_many :post_tags
  has_many :posts, through: :post_tags
end
