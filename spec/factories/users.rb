FactoryBot.define do
  factory :user do
    sequence(:email_address) { |n| "test#{n}@email.com" }
    password { "password" }
  end
end
