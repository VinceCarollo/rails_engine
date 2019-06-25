class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoices

  def self.find_by_created_at(date)
    Merchant.find_by(created_at: date)
  end

  def self.find_by_updated_at(date)
    Merchant.find_by(updated_at: date)
  end

  def self.find_all_by_created_at(date)
    Merchant.where(created_at: date)
  end

  def self.find_all_by_updated_at(date)
    Merchant.where(updated_at: date)
  end

  def self.random
    ids = Merchant.pluck(:id).shuffle
    Merchant.find(ids[0])
  end

  def self.find_all_by_name(name)
    Merchant.where(name: name)
  end

  def self.find_all_by_id(id)
    Merchant.where(id: id)
  end
end
