require 'rails_helper'

RSpec.describe 'Items API' do

  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items['data'].count).to eq(3)
  end

  it "sends one item by id" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item['data']['attributes']['id']).to eq(id)
  end

  it "can find one item by name" do
    name = create(:item).name

    get "/api/v1/items/find?name=#{name}"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item['data']['attributes']['name']).to eq(name)
  end

  it "can find one item by id" do
    id = create(:item).id

    get "/api/v1/items/find?id=#{id}"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item['data']['attributes']['id']).to eq(id)
  end

  it "can find one item by created at" do
    created_at = create(:item).created_at

    get "/api/v1/items/find?created_at=#{created_at}"

    expect(response).to be_successful
  end

  it "can find one item by updated at" do
    updated_at = create(:item).updated_at

    get "/api/v1/items/find?updated_at=#{updated_at}"

    expect(response).to be_successful
  end

  it "can find one item by merchant id" do
    merchant_id = create(:item).merchant_id

    get "/api/v1/items/find?merchant_id=#{merchant_id}"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item['data']['attributes']['merchant_id']).to eq(merchant_id)
  end

  it "can find one item by unit price" do
    unit_price = create(:item).unit_price

    get "/api/v1/items/find?unit_price=#{unit_price}"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item['data']['attributes']['unit_price']).to eq(unit_price.to_f.to_s)
  end

  it "can find one item by description" do
    description = create(:item).description

    get "/api/v1/items/find?description=#{description}"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item['data']['attributes']['description']).to eq(description)
  end

  it "can find all items by id" do
    id = create(:item).id

    get "/api/v1/items/find_all?id=#{id}"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item['data'].first['id']).to eq(id.to_s)
  end

  it "can find all items by name" do
    item_1 = create(:item)
    item_2 = create(:item, name: 'vince')
    item_3 = create(:item, name: 'vince')

    get "/api/v1/items/find_all?name=vince"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items['data'].first['attributes']['name']).to eq('vince')
    expect(items['data'].last['attributes']['name']).to eq('vince')
  end

  it "can find all items by created_at" do
    created = Time.now + 3000
    item_1 = create(:item)
    item_2 = create(:item, created_at: created)
    item_3 = create(:item, created_at: created)

    get "/api/v1/items/find_all?created_at=#{created}"

    expect(response).to be_successful
  end

  it "can find all items by updated_at" do
    updated = Time.now + 3000
    item_1 = create(:item)
    item_2 = create(:item, updated_at: updated)
    item_3 = create(:item, updated_at: updated)

    get "/api/v1/items/find_all?updated_at=#{updated}"

    expect(response).to be_successful
  end

  it "can find all items by merchant_id" do
    merchant = create(:merchant)
    item_1 = create(:item)
    item_2 = create(:item, merchant: merchant)
    item_3 = create(:item, merchant: merchant)

    get "/api/v1/items/find_all?merchant_id=#{merchant.id}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items['data'].first['id']).to eq(item_3.id.to_s)
    expect(items['data'].last['id']).to eq(item_2.id.to_s)
  end

  it "can find all items by price" do
    price = 100.99
    item_1 = create(:item, unit_price: price)
    item_2 = create(:item, unit_price: price)
    item_3 = create(:item)

    get "/api/v1/items/find_all?unit_price=#{price}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items['data'].first['id']).to eq(item_1.id.to_s)
    expect(items['data'].last['id']).to eq(item_2.id.to_s)
  end

  it "can find all items by description" do
    description = 'item description'
    item_1 = create(:item, description: description)
    item_2 = create(:item, description: description)
    item_3 = create(:item)

    get "/api/v1/items/find_all?description=#{description}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items['data'].first['id']).to eq(item_1.id.to_s)
    expect(items['data'].last['id']).to eq(item_2.id.to_s)
  end

  it "can find a random item" do
    create_list(:item, 3)

    get "/api/v1/items/random"

    item = JSON.parse(response.body)

    id = item['data']['attributes']['id']
    expect(Item.find(id)).to be_instance_of(Item)
  end

  it "can find associated invoice items" do
    item = create(:item)
    invoice_item_1 = create(:invoice_item, item: item)
    invoice_item_2 = create(:invoice_item, item: item)

    get "/api/v1/items/#{item.id}/invoice_items"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items['data'].first['id']).to eq(invoice_item_1.id.to_s)
  end

  it "can find associated merchant" do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant['data']['id']).to eq(item.merchant_id.to_s)
  end

end
