require 'spec_helper'

describe "Articles page" do
  subject { page }

  describe "index page" do
    let(:post) { FactoryGirl.create(:post) }
    before { visit root_path }

    it { should have_selector('h2 a', text: post.title) }
    it { should have_selector('h2 span.hint', text: post.post_date) }
    #it { should have_content(post.post_date) }

  end

end