FactoryGirl.define do


  factory :user do
    name "test"
    password "test_password"
    password_confirmation "test_password"
  end


  factory :post do
    title  "Title #1"
    content "*content*"
    #content_display "<b>content</b>"
    status 2
    post_time Time.now.to_i
    author_id 1
    url "post_1"
  end
end