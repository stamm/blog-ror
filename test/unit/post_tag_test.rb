# == Schema Information
#
# Table name: post_tags
#
#  id      :integer          not null, primary key
#  post_id :integer          default(0), not null
#  tag_id  :integer          default(0), not null
#

require 'test_helper'

class PostTagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
