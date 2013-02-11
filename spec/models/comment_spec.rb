require 'spec_helper'

describe Comment do

  it "get status id" do
    Comment::STATUS_TYPES.to_enum.with_index(1).each do |elem, i|
      Comment.get_status(elem).should == i
    end
  end

  it "get status symbol" do
    Comment::STATUS_TYPES.to_enum.with_index(1).each do |elem, i|
      com = Comment.new status: Comment.get_status(elem)
      com.get_status.should == elem
    end
  end

end