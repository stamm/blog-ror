# encoding: utf-8
require 'spec_helper'

describe "Sessions page" do
  subject { page }

  let(:submit) { "Login" }
  let(:user) do
    @user = FactoryGirl.build(:user)
    User.delete_all name: @user.name

    @user.save
    @user
  end
  describe "login" do
    before { visit login_path }

    it "with invalid information" do
      should_not have_content(user.name)
      within 'form' do
        fill_in "Name", with: user.name
        fill_in "Password", with: user.name
        click_button submit
      end
      current_path.should == login_path
      should_not have_content(user.name)
    end


    it "with valid information" do
      should_not have_content(user.name)
      within 'form' do
        fill_in "Name", with: user.name
        fill_in "Password", with: 123456
        click_button submit
      end

      current_path.should == admin_path
      should have_content(user.name)
    end

  end

  describe "logout" do
    before { visit login_path }
    it "work" do
      should_not have_content(user.name)
      within 'form' do
        fill_in "Name", with: user.name
        fill_in "Password", with: 123456
        click_button submit
      end
      click_link "Выйти"
      current_path.should == root_path
      should_not have_content(user.name)
    end

  end

end