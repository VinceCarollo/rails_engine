require 'csv'
require 'pry'

task import: [:environment] do
  Merchant.destroy_all
  Customer.destroy_all
  Item.destroy_all
  Invoice.destroy_all
  Transaction.destroy_all

  merch_file = 'db/merchants.csv'
  customer_file = 'db/customers.csv'
  item_file = 'db/items.csv'
  invoice_file = 'db/invoices.csv'
  transaction_file = 'db/transactions.csv'

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

  CSV.foreach(invoice_file, headers: true) do |row|
    Invoice.create(
      id: row['id'],
      customer_id: row['customer_id'],
      merchant_id: row['merchant_id'],
      status: row['status'],
      created_at: row['created_at'],
      updated_at: row['updated_at']
    )
  end

  CSV.foreach(transaction_file, headers: true) do |row|
    Transaction.create(
      id: row['id'],
      invoice_id: row['invoice_id'],
      credit_card_number: row['credit_card_number'],
      result: row['result'],
      created_at: row['created_at'],
      updated_at: row['updated_at']
    )
  end
end
