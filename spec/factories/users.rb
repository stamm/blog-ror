FactoryGirl.define do
  factory :user do
    name { Faker::Name.first_name}
    password "123456"
    password_confirmation { password}
  end
end