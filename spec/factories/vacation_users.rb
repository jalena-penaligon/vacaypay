FactoryBot.define do
  factory :vacation_user do
    user
    vacation
    role { 0 }
  end

  factory :owner, parent: :vacation_user do
    role { 1 }
  end
end