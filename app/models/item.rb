class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.random
    ids = Item.pluck(:id).shuffle
    Item.find(ids[0])
  end
  
end
