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


    describe "with invalid information" do
      before do
        fill_in "Name", with: user.name
        fill_in "Password", with: user.name
      end
      it do
        should_not have_content(user.name)
        click_button submit
        current_path.should == login_path
        should_not have_content(user.name)
      end
    end


    describe "with valid information" do
      before do
          fill_in "Name", with: user.name
          fill_in "Password", with: "test_password"
      end
      it do
        should_not have_content(user.name)
        click_button submit
        current_path.should == admin_path
        should have_content(user.name)
      end
    end
    #
    #it "Ok" do
    #
    #  should_not have_content("test")
    #  fill_in "Name", with: "test"
    #  fill_in "Password", with: "test_password"
    #
    #  click_button submit
    #
    #  #response.should redirect_to(admin_path)
    #  current_path.should == admin_path
    #
    #  should have_content("test")
    #end
    #
    #it "Bad" do
    #  fill_in "Name", with: "test"
    #  fill_in "Password", with: "test_password1"
    #
    #  click_button "Login"
    #
    #  current_path.should == login_path
    #end

  end

end