require 'spec_helper'

describe Tag do

  subject { Tag }

  before {
    Tag.delete_all
  }

  describe '::tag' do
    it 'empty' do
      expect(subject.tags).to be_empty
    end

    it 'no empty' do
      Tag.create(name: 'rails', frequency: 2)
      expect(subject.tags).to eq({'rails' => 2})
    end
  end

  describe '::recount_frequency' do
    it 'recount' do
      post = build :post
      post.tag_list = 'rails, debian'
      post.save
      #expect(subject.count).to eq(2)

      post2 = build :post
      post2.tag_list = 'rails, ubuntu'
      post2.save
      #expect(subject.count).to eq(3)

      expect{subject.recount_frequency}.to change{subject.tags['rails']}.from(0).to(2)
      expect(subject.tags).to eq({'rails' => 2, 'debian' => 1, 'ubuntu' => 1})
    end
  end

end