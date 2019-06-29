class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.random
    ids = Item.pluck(:id).shuffle
    find(ids[0])
  end

  def self.top_by_revenue(limit)
    joins(invoice_items: [invoice: :transactions])
        .merge(Transaction.successful)
        .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
        .group(:id)
        .order('revenue DESC')
        .limit(limit)
  end

  def self.top_by_amount_sold(limit)
    joins(invoice_items: [invoice: :transactions])
        .merge(Transaction.successful)
        .select('items.*, sum(invoice_items.quantity) AS amount_sold')
        .group(:id)
        .order('amount_sold DESC')
        .limit(limit)
  end

  def best_day
    invoices.joins(:transactions)
        .select('LEFT(CAST(invoices.updated_at as text), 10) AS best_day, sum(invoice_items.quantity) AS amount_sold')
        .group('best_day')
        .order('amount_sold DESC, best_day DESC')
        .take
  end

end
