require 'spec_helper'

describe Comment do

  subject { build :comment }

  it_should_behave_like 'content_display'


  describe 'status' do
    it "get status id" do
      Comment::STATUS_TYPES.to_enum.with_index(1).each do |elem, i|
        expect(Comment.get_status(elem)).to eq i-1
      end
    end

    it "get status symbol" do
      Comment::STATUS_TYPES.to_enum.with_index(1).each do |elem, i|
        com = Comment.new status: Comment.get_status(elem)
        expect(com.get_status).to eq elem
      end
    end
  end

  describe 'singles method' do
    before {
      subject.status = Comment.get_status(:pending)
      subject.save
    }
    it 'set spam' do
      subject.set_spam
      expect(subject.status).to eq Comment.get_status(:spam)
    end
    it 'set approve' do
      subject.set_approve
      expect(subject.status).to eq Comment.get_status(:approve)
    end
  end

end