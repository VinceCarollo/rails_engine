class Transaction < ApplicationRecord
  validates_presence_of :credit_card_number, :result
  belongs_to :invoice

  scope :successful, -> { where(result: 'success') }

  def self.revenue_on_date(date)
    Transaction.joins(invoice: :invoice_items).where(created_at: date).select('sum(invoice_items.quantity * invoice_items.unit_price) AS total_revenue').group(:id)
  end
end
