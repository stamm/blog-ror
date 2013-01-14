require 'spec_helper'

describe "Sessions page" do
  subject { page }

  describe "login" do
    before { visit login_path }

    let(:submit) { "Login" }

    let(:user) do
      @user = FactoryGirl.build(:user)
      User.delete_all name: @user.name

      @user.save
      @user
    end


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

end