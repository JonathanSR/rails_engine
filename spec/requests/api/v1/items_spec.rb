require 'rails_helper'

describe "Items API" do
  it "returns all items" do
    create_list(:item, 3)

    get '/api/v1/items'

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(3)
  end

  it "can get a single item by its id" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["id"]).to eq(id)
  end

  it "returns a single item by name" do
    item = create(:item)

    get "/api/v1/items/find?name=#{item.name}"

    returned_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_item["name"]).to eq("name")
  end

it "returns a single item by name" do
    item = create(:item)

    get "/api/v1/items/find?name=#{item.name}"

    returned_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_item["name"]).to eq(item.name)
  end

  it "returns a single item by description" do
    item = create(:item)

    get "/api/v1/items/find?description=#{item.description}"

    returned_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_item["description"]).to eq(item.description)
  end

  it "returns a single item by unit_price" do
    item = create(:item)

    get "/api/v1/items/find?unit_price=#{item.unit_price}"

    returned_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_item["unit_price"]).to eq("100.00")
  end

  it "returns a single item by merchant_id" do
    item = create(:item)

    get "/api/v1/items/find?merchant_id=#{item.merchant_id}"

    returned_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_item["merchant_id"]).to eq(item.merchant_id)
  end

  it "returns a single item by created at" do
    item = create(:item, id: 110, created_at: "2014-11-07 12:12:12")

    get "/api/v1/items/find?created_at=2014-11-07 12:12:12"

    returned_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_item["id"]).to eq(110)
  end

  it "returns a single item by updated at" do
    item = create(:item, id: 130, updated_at: "2014-11-07 12:12:12")

    get "/api/v1/items/find?updated_at=2014-11-07 12:12:12"

    returned_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_item["id"]).to eq(130)
  end

  it "returns all items with same id" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["id"]).to eq(id)
  end

  it "returns all items with same name" do
    create_list(:item, 3)
    create_list(:item, 3, name: "shovel")

    get "/api/v1/items/find_all?name=shovel"

    returned_items = JSON.parse(response.body)
    first_item = returned_items.first


    expect(response).to be_success
    expect(returned_items.count).to eq(3)
    expect(first_item["name"]).to eq("shovel")
  end

  it "returns all items with same description" do
    create_list(:item, 3)
    create_list(:item, 3, description: "fun")

    get "/api/v1/items/find_all?description=fun"

    returned_items = JSON.parse(response.body)
    first_item = returned_items.first


    expect(response).to be_success
    expect(returned_items.count).to eq(3)
    expect(first_item["description"]).to eq("fun")
  end

  it "returns all items with same unit price" do
    create_list(:item, 3)
    create_list(:item, 3, unit_price: 1234)

    get "/api/v1/items/find_all?unit_price=1234"

    returned_items = JSON.parse(response.body)
    first_item = returned_items.first

    expect(response).to be_success
    expect(returned_items.count).to eq(3)
    expect(first_item["unit_price"]).to eq("12.34")
  end

   it "returns all items with same merchant id" do
    create_list(:item, 3)
    merchant = create(:merchant)
    create_list(:item, 3, merchant: merchant)

    get "/api/v1/items/find_all?merchant_id=#{merchant.id}"

    returned_items = JSON.parse(response.body)
    first_item = returned_items.first

    expect(response).to be_success
    expect(returned_items.count).to eq(3)
    expect(first_item["merchant_id"]).to eq(merchant.id)
  end

   it "returns all items with same created_at" do
    create_list(:item, 3)

    get "/api/v1/items/find_all?created_at=2014-11-07T12:12:12.000Z"

    returned_items = JSON.parse(response.body)
    first_item = returned_items.first

    expect(response).to be_success
    expect(returned_items.count).to eq(3)
  end

  it "returns all items with same updated_at" do
    item1 = create(:item, updated_at: "2014-11-07 12:12:12.000Z")
    item2 = create(:item, updated_at: "2014-11-07 12:12:12.000Z")
    item3 = create(:item, updated_at: "2014-11-07 12:12:12.000Z")

    get "/api/v1/items/find_all?updated_at=2014-11-07T12:12:12"

    returned_items = JSON.parse(response.body)
    first_item = returned_items.first

    expect(response).to be_success
    expect(returned_items.count).to eq(3)
  end

  it "returns a random invoice record" do
    create_list(:item, 3)
    get '/api/v1/items/random'

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.class).to eq(Hash)
  end

  it "returns top items ranked by total revenue" do
    item1 = create(:item)
    item2 = create(:item)
    item3 = create(:item)
    invoice1 = create(:invoice)
    invoice2 = create(:invoice)
    invoice_item1 = create(:invoice_item, invoice_id: invoice1.id, item_id: item1.id, quantity: 2, unit_price: 5000)
    invoice_item2 = create(:invoice_item, invoice_id: invoice2.id, item_id: item2.id, quantity: 1, unit_price: 5000)
    transaction1 = create(:transaction, result: 'success', invoice_id: invoice1.id)
    transaction2 = create(:transaction, result: 'success', invoice_id: invoice2.id)

    get "/api/v1/items/most_revenue?quantity=2"

    returned_result = JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_result.count).to eq(2)
  end

  it "returns top items ranked by total items sold" do
    item1 = create(:item)
    item2 = create(:item)
    item3 = create(:item)
    invoice1 = create(:invoice)
    invoice2 = create(:invoice)
    invoice3 = create(:invoice)
    invoice_item1 = create(:invoice_item, invoice_id: invoice1.id, item_id: item1.id, quantity: 10, unit_price: 1000)
    invoice_item2 = create(:invoice_item, invoice_id: invoice2.id, item_id: item2.id, quantity: 5, unit_price: 1000)
    invoice_item2 = create(:invoice_item, invoice_id: invoice3.id, item_id: item3.id, quantity: 1, unit_price: 1000)
    transaction1 = create(:transaction, result: 'success', invoice_id: invoice1.id)
    transaction2 = create(:transaction, result: 'success', invoice_id: invoice2.id)
    transaction3 = create(:transaction, result: 'success', invoice_id: invoice3.id)

    get "/api/v1/items/most_items?quantity=2"

    returned_result = JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_result.count).to eq(2)
  end
end
