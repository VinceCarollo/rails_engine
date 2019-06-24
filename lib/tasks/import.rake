require 'csv'
require 'pry'

task import: [:environment] do
  Merchant.destroy_all
  Customer.destroy_all

  merch_file = 'db/merchants.csv'
  customer_file = 'db/customers.csv'

  CSV.foreach(merch_file, headers: true) do |row|
    Merchant.create(
      id: row['id'],
      name: row['name'],
      created_at: row['created_at'],
      updated_at: row['updated_at']
    )
  end

  CSV.foreach(customer_file, headers: true) do |row|
    Customer.create(
      id: row['id'],
      first_name: row['first_name'],
      last_name: row['last_name'],
      created_at: row['created_at'],
      updated_at: row['updated_at']
    )
  end
end
