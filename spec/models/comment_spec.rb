require 'spec_helper'

describe Comment do

  it "get status id" do
    Comment::STATUS_TYPES.to_enum.with_index(1).each do |elem, i|
      expect(Comment.get_status(elem)).to eq i
    end
  end

  it "get status symbol" do
    Comment::STATUS_TYPES.to_enum.with_index(1).each do |elem, i|
      com = Comment.new status: Comment.get_status(elem)
      expect(com.get_status).to eq elem
    end
  end

end