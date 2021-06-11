FactoryBot.define do
  factory :event do
    association :user
    title { 'Шашлыки' }
    address { 'Москва' }
    datetime { Time.now }
  end
end
