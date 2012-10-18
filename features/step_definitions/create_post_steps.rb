# encoding: utf-8
Given /^a user visits the post new page$/  do
	visit new_post_path
end

When /^he submits invalid publish post information$/ do
	click_button "Create"
end

Then /^he should see an error message$/ do
	page.should have_selector('div#error_explanation')
end

When /^a user submits valid publish post information$/ do
	fill_in "post_title", with: "Cool post"
	fill_in "post_content", with: "Usual Text"
	select 'Опубликовано', from: "post_status"
	fill_in "post_post_time_string", with: "2012-08-30 00:00:00"
	fill_in "post_url", with: "cool_post"
	click_button "Create"
end

Then /^he should see a post link on root page$/ do
	visit root_path
	page.should have_link('Cool post', href: "/cool_post")
end


Given /^a user submits valid arhive post information$/ do
	fill_in "post_title", with: "Cool post"
	fill_in "post_content", with: "Usual Text"
	select 'Черновик', from: "post_status"
	fill_in "post_post_time_string", with: "2012-08-30 00:00:00"
	fill_in "post_url", with: "cool_post"
	click_button "Create"

end

Then /^he shouldn\'t see a post link on root page$/ do
	visit root_path
	page.should_not have_link('Cool post', href: "/cool_post")
end