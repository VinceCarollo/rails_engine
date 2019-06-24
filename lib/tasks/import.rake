require 'csv'
require 'pry'

task import: [:environment] do
  merch_file = 'db/merchants.csv'

  CSV.foreach(merch_file, headers: true) do |row|
    Merchant.create(
      name: row['name'],
      created_at: row['created_at'],
      updated_at: row['updated_at']
    )
  end
end
