require 'csv'
require 'pry'

task import: [:environment] do
  Merchant.destroy_all
  Customer.destroy_all
  Item.destroy_all

  merch_file = 'db/merchants.csv'
  customer_file = 'db/customers.csv'
  item_file = 'db/items.csv'

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

  CSV.foreach(item_file, headers: true) do |row|
    Item.create(
      id: row['id'],
      name: row['name'],
      description: row['description'],
      unit_price: (row['unit_price'].to_f / 100).round(2),
      merchant_id: row['merchant_id'],
      created_at: row['created_at'],
      updated_at: row['updated_at']
    )
  end
end
