class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoices

  def self.find_by_created_at(date)
    find_by(created_at: date)
  end

  def self.find_by_updated_at(date)
    find_by(updated_at: date)
  end

  def self.find_all_by_created_at(date)
    where(created_at: date)
  end

  def self.find_all_by_updated_at(date)
    where(updated_at: date)
  end

  def self.random
    ids = self.pluck(:id).shuffle
    find(ids[0])
  end

  def self.find_all_by_name(name)
    where(name: name)
  end

  def self.find_all_by_id(id)
    where(id: id)
  end

  def self.top_by_revenue(limit)
    joins(items: [invoices: [:transactions]])
        .merge(Transaction.successful)
        .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
        .group(:id)
        .order('revenue DESC')
        .limit(limit)
  end

  def self.top_by_items_sold(limit)
    joins(items: [invoices: [:transactions]])
        .merge(Transaction.successful)
        .select('merchants.*, sum(invoice_items.quantity) AS items_sold')
        .group(:id)
        .order('items_sold DESC')
        .limit(limit)
  end

  def self.best_for(customer)
    joins(invoices: :transactions)
        .where("invoices.customer_id=#{customer.id}")
        .merge(Transaction.successful)
        .select('merchants.*, count(transactions.id) AS transaction_count')
        .group(:id)
        .order('transaction_count DESC')
        .first
  end

  def total_revenue
    invoices.joins(:transactions, :invoice_items)
        .merge(Transaction.successful)
        .select('sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
        .take
  end

  def total_revenue_by_date(date)
    invoices.joins(:transactions, :invoice_items)
        .merge(Transaction.successful)
        .select('sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
        .where('CAST(invoices.updated_at AS text) LIKE ?', "#{date}%")
        .take
  end
end
