require 'rails_helper'

RSpec.describe "Transactions API" do

  it "gets all transactions" do
    create_list(:transaction, 3)

    get '/api/v1/transactions'

    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions['data'].count).to eq(3)
  end

  it 'gets one transaction' do
    id = create(:transaction).id

    get "/api/v1/transactions/#{id}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)

    expect(transaction['data']['id']).to eq(id.to_s)
  end

  it 'can get one transaction by credit card number' do
    transaction_1 = create(:transaction)
    transaction_2 = create(:transaction, credit_card_number: '1234')

    get "/api/v1/transactions/find?credit_card_number=1234"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)

    expect(transaction['data']['id']).to eq(transaction_2.id.to_s)
  end

  it 'can find all transactions by credit card number' do
    transaction_1 = create(:transaction, credit_card_number: '1234')
    transaction_2 = create(:transaction, credit_card_number: '1234')

    get "/api/v1/transactions/find_all?credit_card_number=1234"

    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions['data'].count).to eq(2)
  end

  it "gets the associated invoice" do
    invoice = create(:invoice)
    transaction = create(:transaction, invoice: invoice)

    get "/api/v1/transactions/#{transaction.id}/invoice"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices['data']['id']).to eq(invoice.id.to_s)
  end

end
