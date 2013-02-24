# encoding: utf-8
require 'spec_helper'

describe "Sessions page" do
  subject { page }

  let(:user) { create(:user) }

  describe "login" do
    it "with invalid information" do
      user.password = user.name
      sign_in user
      current_path.should == login_path
      should_not have_content(user.name)
    end


    it "with valid information" do
      sign_in user
      current_path.should == admin_path
      should have_content(user.name)
    end

  end

  describe "logout" do
    it "work" do
      sign_in user
      click_link t(:logout)
      current_path.should == root_path
      should_not have_content(user.name)
    end
  end

end