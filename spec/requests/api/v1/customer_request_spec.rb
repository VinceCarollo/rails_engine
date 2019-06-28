require 'rails_helper'

RSpec.describe 'Customer API' do

  it "gets all customers" do
    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers['data'].count).to eq(3)
  end

  it "gets one customer" do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)

    expect(customer['data']['id']).to eq(id.to_s)
  end

  it "can find one customer by first name" do
    first_name = create(:customer).first_name

    get "/api/v1/customers/find?first_name=#{first_name}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)

    expect(customer['data']['attributes']['first_name']).to eq(first_name)
  end

  it "can find all customers by first name" do
    customer_1 = create(:customer)
    customer_2 = create(:customer, first_name: 'vince')
    customer_3 = create(:customer, first_name: 'vince')

    get "/api/v1/customers/find_all?first_name=vince"

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers['data'].count).to eq(2)
  end

  it "can find all associated invoices" do
    customer = create(:customer)
    invoice_1 = create(:invoice, customer: customer)
    invoice_2 = create(:invoice, customer: customer)
    invoice_3 = create(:invoice)

    get "/api/v1/customers/#{customer.id}/invoices"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices['data'].count).to eq(2)
  end

  it "can find all associated tranactions" do
    customer = create(:customer)
    invoice_1 = create(:invoice, customer: customer)
    invoice_2 = create(:invoice, customer: customer)
    create(:transaction, invoice: invoice_1)
    create(:transaction, invoice: invoice_2)
    create(:transaction)

    get "/api/v1/customers/#{customer.id}/transactions"

    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions['data'].count).to eq(2)
  end

end
