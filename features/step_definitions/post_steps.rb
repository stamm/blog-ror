# encoding: utf-8
Given /^I login as admin$/ do
  user = get_user
  visit login_path
  fill_in "Name",    with: user.name
  fill_in "Password", with: user.password
  click_button "Login"
  page.should have_selector('li.nav-header', text: @user.name)
  page.should have_link('Выйти', href: logout_path)
  #session[:user_id].should == user.id
end


Given /^I add valid post$/ do
  visit new_post_path
  page.should have_content('Новый пост')
  post = FactoryGirl.build(:post)
  fill_in "post_title", with: post.title
  fill_in "post_content", with: post.content
  select "Опубликовано", from: "post_status"
  fill_in "post_post_time_string", with: post.post_time_string
  fill_in "post_url", with: post.url
  click_button "Create Пост"
  Post.last.title.should == post.title
end

Then /^I should see valid post on main page$/ do
  visit root_path
  post = FactoryGirl.build(:post)
  page.should have_content(post.title)
end