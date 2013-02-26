FactoryGirl.define do
  factory :comment do
    author { Faker::Name.name }
    email { Faker::Internet.email }
    content { Faker::Lorem.sentence }
    factory :invalid_comment do
      content nil
    end
  end
end