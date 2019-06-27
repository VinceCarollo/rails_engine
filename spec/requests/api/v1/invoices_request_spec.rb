require 'rails_helper'

RSpec.describe "Invoices API" do

  it 'gets all invoices' do
    create_list(:invoice, 3)

    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices['data'].count).to eq(3)
  end

  it 'gets one invoice' do
    id = create(:invoice).id

    get "/api/v1/invoices/#{id}"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices['data']['id']).to eq(id.to_s)
  end

  it 'sends one invoice by searched status' do
    invoice_1 = create(:invoice)
    invoice_2 = create(:invoice)
    invoice_3 = create(:invoice, status: 'some status')

    get "/api/v1/invoices/find?status=some status"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)

    expect(invoice['data']['id']).to eq(invoice_3.id.to_s)
  end

  it 'sends one invoice by searched id' do
    id = create(:invoice).id

    get "/api/v1/invoices/find?id=#{id}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)

    expect(invoice['data']['id']).to eq(id.to_s)
  end

  it "can find all by searched status" do
    invoice_1 = create(:invoice)
    invoice_2 = create(:invoice, status: 'some status')
    invoice_3 = create(:invoice, status: 'some status')

    get "/api/v1/invoices/find_all?status=some status"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices['data'].count).to eq(2)
  end

  it "can get all associated transactions" do
    invoice = create(:invoice)
    transaction = create(:transaction, invoice: invoice)
    transaction = create(:transaction, invoice: invoice)

    get "/api/v1/invoices/#{invoice.id}/transactions"

    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions['data'].count).to eq(2)
  end

  it "can get all associated Invoice Items" do
    invoice = create(:invoice)
    ii_1 = create(:invoice_item, invoice: invoice)
    ii_2 = create(:invoice_item, invoice: invoice)

    get "/api/v1/invoices/#{invoice.id}/invoice_items"

    expect(response).to be_successful

    iis = JSON.parse(response.body)

    expect(iis['data'].count).to eq(2)
  end

  it "gets all associated items" do
    invoice = create(:invoice)
    item_1 = create(:item)
    item_2 = create(:item)
    ii_1 = create(:invoice_item, invoice: invoice, item: item_1)
    ii_2 = create(:invoice_item, invoice: invoice, item: item_2)

    get "/api/v1/invoices/#{invoice.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items['data'].count).to eq(2)
  end

  it 'gets associated customer' do
    customer = create(:customer)
    invoice = create(:invoice, customer: customer)

    get "/api/v1/invoices/#{invoice.id}/customer"

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers['data']['id']).to eq(customer.id.to_s)
  end

  it 'gets associated merchant' do
    merchant = create(:merchant)
    invoice = create(:invoice, merchant: merchant)

    get "/api/v1/invoices/#{invoice.id}/merchant"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants['data']['id']).to eq(merchant.id.to_s)
  end

end
