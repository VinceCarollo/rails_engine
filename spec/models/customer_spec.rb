require 'rails_helper'

RSpec.describe Customer, type: :model do

  describe 'validations' do
    it { should validate_presence_of :first_name}
    it { should validate_presence_of :last_name}
  end

  describe 'relationships' do
    it { should have_many :invoices}
  end

  describe 'class methods' do

    it ".find_all_by" do
      customer = create(:customer)
      params = {id: customer.id}

      customers = Customer.find_all_by(params)

      expect(customers.first).to eq(customer)
    end

  end

  describe 'instance methods' do

    it "#transactions" do
      customer = create(:customer)
      invoice_1 = create(:invoice, customer: customer)
      invoice_2 = create(:invoice, customer: customer)
      create(:transaction, invoice: invoice_1)
      create(:transaction, invoice: invoice_2)
      create(:transaction)

      transactions = customer.transactions

      transactions.each do |transaction|
        expect(transaction).to be_instance_of(Transaction)
      end
      
      expect(transactions.count).to eq(2)
    end

  end

end
