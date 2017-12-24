FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password "password"
    password_confirmation "password"
    confirmed_at Time.zone.today
    pot
    variety
  end

  factory :pot do
    name "Break Room"
  end

  factory :variety do
    name "Coffee & Chicory"
  end

  factory :brew do
    pot
    variety
    user
  end
end
