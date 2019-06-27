require 'rails_helper'

RSpec.describe 'Invoices API' do

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

end
