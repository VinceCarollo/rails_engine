FactoryBot.define do
  factory :invoice do |fac|
    status { 'shipped' }
    fac.association :customer
  end
end
