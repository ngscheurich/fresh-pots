FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password "password"
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
