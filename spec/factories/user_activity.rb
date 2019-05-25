FactoryBot.define do
  factory :user_activity do
    activity
    user
    quantity { Faker::Number.number(1)}
    price { Faker::Number.decimal(2) }
  end
end