require 'spec_helper'

describe "Articles page" do
  subject { page }
  describe "index page" do
    let!(:post) { create :post }
    it 'have a post data' do
      visit root_path
      should have_selector('h3 a', text: post.title)
      should have_selector('h3 span.hint', text: post.post_date)
      should have_content(post.post_date)
    end
  end
end