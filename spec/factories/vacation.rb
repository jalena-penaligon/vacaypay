FactoryBot.define do
  factory :vacation do
    name { Faker::Lorem.word }
    location { Faker::WorldCup.city }
    start_date { Faker::Date }
    end_date { Faker::Date.forward(5) }
  end
end 