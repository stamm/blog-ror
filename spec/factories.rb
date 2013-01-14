FactoryGirl.define do


  factory :user do
    sequence(:name) { |n| "foo#{n}" }
    password "123456"
    password_confirmation { password}
  end


  factory :post do
    sequence(:title) { |n| "Title #{n}" }
    content "*content*"
    #content_display "<b>content</b>"
    status 2
    post_time Time.now.to_i
    author_id 1
    sequence(:url) {|n| "post_#{n}"}
  end
end