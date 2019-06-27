class Transaction < ApplicationRecord
  validates_presence_of :credit_card_number, :result
  belongs_to :invoice

  scope :successful, -> { where(result: 'success') }

  def self.revenue_on_date(date)
    joins(invoice: :invoice_items)
        .merge(Transaction.successful)
        .select('sum(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
        .where('CAST(invoices.updated_at AS text) LIKE ?', "#{date}%")
        .take
  end

end
