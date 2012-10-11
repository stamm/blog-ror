require 'spec_helper'

describe "Articles page" do
  subject { page }
  #after(:each) {  }

  describe "index page" do
    let(:post)  do
      Post.delete_all
      FactoryGirl.create :post
    end
    before { post }


    it 'have post' do

      visit root_path

      should have_selector('h2 a', text: post.title)
      should have_selector('h2 span.hint', text: post.post_date)
      should have_content(post.post_date)
    end


  end

end