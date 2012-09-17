# == Schema Information
#
# Table name: tags
#
#  id        :integer          not null, primary key
#  name      :string(255)      not null
#  frequency :integer          default(0), not null
#

require 'test_helper'

class TagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
