require 'rails_helper'

RSpec.describe "Invoice Items API" do

  it "it gets all invoice items" do
    create_list(:invoice_item, 3)

    get '/api/v1/invoice_items'

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items['data'].count).to eq(3)
  end

  it "gets one invoice item" do
    id = create(:invoice_item).id

    get "/api/v1/invoice_items/#{id}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item['data']['id']).to eq(id.to_s)
  end

  it 'can find one invoice item by quantity' do
    invoice_item = create(:invoice_item, quantity: 30)

    get "/api/v1/invoice_items/find?quantity=30"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items['data']['id']).to eq(invoice_item.id.to_s)
  end

  it "can find all invoice items by quantity" do
    invoice_item_1 = create(:invoice_item)
    invoice_item_2 = create(:invoice_item, quantity: 30)
    invoice_item_3 = create(:invoice_item, quantity: 30)

    get "/api/v1/invoice_items/find_all?quantity=30"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items['data'].count).to eq(2)
  end

  it "can find the associated invoice" do
    invoice = create(:invoice)
    invoice_item = create(:invoice_item, invoice: invoice)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices['data']['id']).to eq(invoice.id.to_s)
  end

  it "can find the associated item" do
    item = create(:item)
    invoice_item = create(:invoice_item, item: item)

    get "/api/v1/invoice_items/#{invoice_item.id}/item"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items['data']['id']).to eq(item.id.to_s)
  end

end
