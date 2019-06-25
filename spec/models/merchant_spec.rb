require 'rails_helper'

RSpec.describe Merchant, type: :model do

  describe 'validations' do
    it { should validate_presence_of :name}
  end

  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :invoices }
  end

  describe 'class methods' do
    it ".find_by_created_at" do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant, created_at: Time.now + 3000)
      date = merchant_2.created_at
      expect(Merchant.find_by_created_at(date)).to eq(merchant_2)
    end

    it ".find_by_updated_at" do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant, updated_at: Time.now + 3000)
      date = merchant_2.updated_at
      expect(Merchant.find_by_updated_at(date)).to eq(merchant_2)
    end

    it ".find_all_by_created_at" do
      time = Time.now
      merchant_1 = create(:merchant, created_at: time)
      merchant_2 = create(:merchant, created_at: time)

      expect(Merchant.find_all_by_created_at(time).count).to eq(2)
    end

    it ".find_all_by_updated_at" do
      time = Time.now
      merchant_1 = create(:merchant, updated_at: time)
      merchant_2 = create(:merchant, updated_at: time)

      expect(Merchant.find_all_by_updated_at(time).count).to eq(2)
    end

    it '.random' do
      create_list(:merchant, 3)

      expect(Merchant.random).to be_instance_of(Merchant)
    end

    it '.find_all_by_name' do
      merch_1 = create(:merchant)
      merch_2 = create(:merchant, name: 'vince')
      merch_3 = create(:merchant, name: 'vince')

      expect(Merchant.find_all_by_name('vince').count).to eq(2)
    end

    it '.find_all_by_id' do
      merch_1 = create(:merchant)

      expect(Merchant.find_all_by_id(merch_1.id).count).to eq(1)
    end
  end

end
