FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.sentence }
    content "*content*"
    #content_display "<b>content</b>"
    status Post::STATUS_TYPES.index(:publish) + 1
    post_time { Time.now.to_i }
    user_id 1
    sequence(:url) {|n| "#{n}_#{Faker::Lorem.sentence.gsub(' ', '_').downcase}" }
    factory :invalid_post do
      title nil
    end
  end
end