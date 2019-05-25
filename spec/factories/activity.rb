FactoryBot.define do
  factory :activity do
    vacation
    user
    name { Faker::Team.sport }
    description { Faker::Marketing.buzzwords }
    price { Faker::Number.decimal(2) }
    cutoff_date { Faker::Date }
    no_of_days { 1 }
    # type { }
  end
end 