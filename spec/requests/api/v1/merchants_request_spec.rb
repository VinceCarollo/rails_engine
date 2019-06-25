require 'rails_helper'

describe 'Merchants API' do

  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get "/api/v1/merchants.json"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants['data'].count).to eq(3)
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

    expect(ids).to include(merchant['data']['id'].to_i)
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

end
