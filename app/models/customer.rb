class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name

  has_many :invoices

  def transactions
    Transaction.where(invoice: self.invoices).order(:id)
  end
end
