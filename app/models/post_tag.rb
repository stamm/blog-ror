# == Schema Information
#
# Table name: post_tags
#
#  id      :integer          not null, primary key
#  post_id :integer          default(0), not null
#  tag_id  :integer          default(0), not null
#

class PostTag < ActiveRecord::Base
  attr_accessible :post_id, :tag_id

  belongs_to :post
  belongs_to :tag
end
