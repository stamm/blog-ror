FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.sentence }
    content "*content*"
    #content_display "<b>content</b>"
    status 2
    post_time Time.now.to_i
    user_id 1
    url { Faker::Lorem.sentence.downcase }
    factory :invalid_post do
      title nil
    end
  end
end