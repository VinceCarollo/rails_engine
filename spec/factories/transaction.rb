FactoryBot.define do
  factory :transaction do |fac|
    credit_card_number { '4654405418249632'}
    result { 'success' }
    fac.association :invoice
  end
end
