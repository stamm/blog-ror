FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "#{n} #{Faker::Name.first_name}"}
    password '123456'
    password_confirmation { password}
  end
end