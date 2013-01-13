# encoding: utf-8
Given /^a user visits the login page$/ do
  visit login_path
end

When /^he submits invalid login information$/ do
  click_button "Login"
end

Then /^he should see a "([^"]+)"$/ do |message|
  page.should have_content(message)
end


Given /^the user has an account$/ do
  @user = FactoryGirl.build(:user)
  User.delete_all name: @user.name

  @user.save
  @user.should be_valid
end

When /^the user submits valid login information$/ do
  fill_in "Name",    with: @user.name
  fill_in "Password", with: "test_password"
  click_button "Login"
end

Then /^he should see his name$/ do
  page.should have_selector('li.nav-header', text: @user.name)
  #page.should have_content(@user.name)
end

Then /^he should see a logout link$/ do
  page.should have_link('Выйти', href: logout_path)
end