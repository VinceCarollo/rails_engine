FactoryBot.define do
  factory :item do
    name { Faker::Game.title }
    description { Faker::ChuckNorris.fact }
    unit_price { 20.99 }
  end
end
