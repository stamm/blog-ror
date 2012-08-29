require 'spec_helper'

describe "ListPosts" do

  let(:base_title) { "Zagirov"}

  describe "Home page" do
    it "should have title" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      #get root_path
      #response.status.should be(200)
      visit root_path
      page.should have_content('test')
      page.should have_selector('title', text: "#{base_title} | Posts")
      page.should have_selector('a', text: 'test')
    end
  end

  describe 'test post' do
    it "should have title" do
      visit article_path 'test'
      page.should have_selector('title', text: "#{base_title} | test")
    end
  end
end
