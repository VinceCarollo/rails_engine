require 'rails_helper'

describe 'Merchants API' do

  before :each do
    @merchant_1 = create(:merchant, name: "Merch1")
    @merchant_2 = create(:merchant, name: "Merch2")
    @merchant_3 = create(:merchant, name: "Merch3")
    @merchant_4 = create(:merchant, name: "Merch4")
    @merchant_5 = create(:merchant, name: "Merch5")
    @merchant_6 = create(:merchant, name: "Merch6")
    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_2)
    @item_3 = create(:item, merchant: @merchant_3)
    @item_4 = create(:item, merchant: @merchant_4)
    @item_5 = create(:item, merchant: @merchant_5)
    @item_6 = create(:item, merchant: @merchant_6)
    @invoice_1 = create(:invoice, merchant: @merchant_1)
    @invoice_2 = create(:invoice, merchant: @merchant_2)
    @invoice_3 = create(:invoice, merchant: @merchant_3)
    @invoice_4 = create(:invoice, merchant: @merchant_4)
    @invoice_5 = create(:invoice, merchant: @merchant_5)
    @invoice_6 = create(:invoice, merchant: @merchant_6)
    @invoice_7 = create(:invoice, merchant: @merchant_6)
    @transaction_1 = create(:transaction, invoice: @invoice_1)
    @transaction_2 = create(:transaction, invoice: @invoice_2)
    @transaction_3 = create(:transaction, invoice: @invoice_3)
    @transaction_4 = create(:transaction, invoice: @invoice_4)
    @transaction_5 = create(:transaction, invoice: @invoice_5)
    @transaction_6 = create(:transaction, invoice: @invoice_6)
    @transaction_7 = create(:transaction, invoice: @invoice_7, result: 'failed')
    @ii_1 = InvoiceItem.create(quantity: 1, item: @item_1, unit_price: 1.0, invoice: @invoice_1)
    @ii_2 = InvoiceItem.create(quantity: 2, item: @item_2, unit_price: 2.0, invoice: @invoice_2)
    @ii_3 = InvoiceItem.create(quantity: 3, item: @item_3, unit_price: 3.0, invoice: @invoice_3)
    @ii_4 = InvoiceItem.create(quantity: 4, item: @item_4, unit_price: 4.0, invoice: @invoice_4)
    @ii_5 = InvoiceItem.create(quantity: 5, item: @item_5, unit_price: 5.0, invoice: @invoice_5)
    @ii_6 = InvoiceItem.create(quantity: 6, item: @item_6, unit_price: 6.0, invoice: @invoice_6)
    @ii_7 = InvoiceItem.create(quantity: 7, item: @item_6, unit_price: 7.0, invoice: @invoice_7)
  end

  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get "/api/v1/merchants.json"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants['data'].count).to eq(9)
  end

  it "sends a merchant by id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}.json"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant['data']['id']).to eq(id.to_s)
  end

  it "sends one merchant by searched name" do
    name = create(:merchant).name

    get "/api/v1/merchants/find?name=#{name}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant['data']['attributes']['name']).to eq(name)
  end

  it "sends one merchant by searched id" do
    id = create(:merchant).id

    get "/api/v1/merchants/find?id=#{id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant['data']['attributes']['id']).to eq(id)
  end

  it "sends one merchant by searched created_at" do
    merch_1 = create(:merchant)
    merch_2 = create(:merchant, created_at: Time.now + 3000)

    created_at = merch_2.created_at.to_s

    get "/api/v1/merchants/find?created_at=#{created_at}"

    expect(response).to be_successful
  end

  it "sends one merchant by searched updated_at" do
    merch_1 = create(:merchant)
    merch_2 = create(:merchant, updated_at: Time.now + 3000)

    updated_at = merch_2.updated_at.to_s

    get "/api/v1/merchants/find?updated_at=#{updated_at}"

    expect(response).to be_successful
  end

  it "finds all merchants by name" do
    merch_1 = create(:merchant)
    merch_2 = create(:merchant, name: 'vince')
    merch_3 = create(:merchant, name: 'vince')

    get "/api/v1/merchants/find_all?name=vince"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)
    expect(merchants['data'].count).to eq(2)
  end

  it "finds all merchants by id" do
    id = create(:merchant).id

    get "/api/v1/merchants/find_all?id=#{id}"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants['data'].count).to eq(1)
  end

  it "finds all merchants by created at" do
    merch_1 = create(:merchant)
    merch_2 = create(:merchant)
    merch_3 = create(:merchant, created_at: Time.now + 3000)

    get "/api/v1/merchants/find_all?created_at=#{merch_1.created_at}"

    expect(response).to be_successful
  end

  it "finds all merchants by updated at" do
    merch_1 = create(:merchant)
    merch_2 = create(:merchant)
    merch_3 = create(:merchant, updated_at: Time.now + 3000)

    get "/api/v1/merchants/find_all?updated_at=#{merch_1.updated_at}"

    expect(response).to be_successful
  end

  it 'can find a random merchant' do
    merch_list = create_list(:merchant, 3)
    ids = merch_list.map(&:id)

    get "/api/v1/merchants/random.json"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    id = merchant['data']['id']
    expect(Merchant.find(id)).to be_instance_of(Merchant)
  end

  it "return items associated with a merchant" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    item_1 = create(:item, merchant: merchant_1)
    item_2 = create(:item, merchant: merchant_1)
    item_3 = create(:item, merchant: merchant_2)

    get "/api/v1/merchants/#{merchant_1.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items['data'].count).to eq(2)
  end

  it "returns invoices assoiciated with a merchant" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    customer = create(:customer)
    invoice_1 = create(:invoice, merchant: merchant_1, customer: customer)
    invoice_2 = create(:invoice, merchant: merchant_1, customer: customer)
    invoice_3 = create(:invoice, merchant: merchant_2, customer: customer)

    get "/api/v1/merchants/#{merchant_1.id}/invoices"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices['data'].count).to eq(2)
  end

  it "returns top merchants by revenue" do
    get "/api/v1/merchants/most_revenue?quantity=5"

    expect(response).to be_successful

    top_merchants = JSON.parse(response.body)

    expect(top_merchants['data'].length).to eq(5)
    expect(top_merchants['data'].first['attributes']['id']).to eq(@merchant_6.id)
    expect(top_merchants['data'].last['attributes']['id']).to eq(@merchant_2.id)
  end

  it "returns top merchants by items sold" do
    get "/api/v1/merchants/most_items?quantity=5"

    expect(response).to be_successful

    top_merchants = JSON.parse(response.body)
    expect(top_merchants['data'].length).to eq(5)
    expect(top_merchants['data'].first['attributes']['id']).to eq(@merchant_6.id)
    expect(top_merchants['data'].last['attributes']['id']).to eq(@merchant_2.id)
  end

  xit "returns total revenue for given date" do
    get "/api/v1/merchants/revenue?date=2012-03-16"

    expect(response).to be_successful

    total_revenue = JSON.parse(response.body)
  end

end
