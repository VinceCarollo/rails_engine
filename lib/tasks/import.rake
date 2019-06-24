require 'csv'
require 'pry'

task import: [:environment] do
  Merchant.destroy_all

  merch_file = 'db/merchants.csv'

  CSV.foreach(merch_file, headers: true) do |row|
    Merchant.create(
      id: row['id'],
      name: row['name'],
      created_at: row['created_at'],
      updated_at: row['updated_at']
    )
  end
end
