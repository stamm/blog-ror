require 'spec_helper'

describe "Articles page" do
  subject { page }
  #after(:each) { Post.delete_all }

  describe "index page" do
    before do
      Post.delete_all
      @post = FactoryGirl.create(:post)
    end
    before { visit root_path }

    it { should have_selector('h2 a', text: @post.title) }
    it { should have_selector('h2 span.hint', text: @post.post_date) }
    #it { should have_content(post.post_date) }

  end

end