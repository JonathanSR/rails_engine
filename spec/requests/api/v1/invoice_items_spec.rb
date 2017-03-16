require 'rails_helper'

describe "Invoice Items API" do
  it "returns all Invoice Items" do
    create_list(:invoice_item, 3)

    get '/api/v1/invoice_items'

    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items.count).to eq(3)
  end

  it "returns a single Invoice Item by its id" do
    id = create(:invoice_item).id

    get "/api/v1/invoice_items/#{id}"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items["id"]).to eq(id)
  end

  it "returns a single item by item id" do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?item_id=#{invoice_item.item_id}"

    returned_invoiceitem = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item["item_id"]).to eq(invoice_item.item_id)
  end

   it "returns a single item by invoice id" do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?invoice_id=#{invoice_item.invoice_id}"

    returned_invoiceitem = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item["invoice_id"]).to eq(invoice_item.invoice_id)
  end

   it "returns a single item by quantity" do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?quantity=#{invoice_item.quantity}"

    returned_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item["quantity"]).to eq(invoice_item.quantity)
  end

   it "returns a single item by unit price" do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?unit_price=#{invoice_item.unit_price}"

    returned_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item["unit_price"]).to eq(invoice_item.unit_price)
  end

  it "returns a single invoice item by created at" do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?created_at=2014-11-07 12:12:12"

    returned_invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_invoice_item["created_at"]).to eq("2014-11-07T12:12:12.000Z")
  end

  it "returns a single invoice item by updated at" do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?created_at=2014-11-07 12:12:12"

    returned_invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_invoice_item["updated_at"]).to eq("2014-11-07T12:12:12.000Z")
  end

  it "returns all Invoice Items with same Id" do
    invoice_item_one = create(:invoice_item)
    invoice_item_one = create(:invoice_item)

    get "/api/v1/invoice_items/find_all?id=#{invoice_item_one.id}"

    invoice_items = JSON.parse(response.body)
    first_invoice_item = invoice_items.first

    expect(response).to be_success
    expect(invoice_items.count).to eq(1)
    expect(first_invoice_item["id"]).to eq(invoice_item_one.id)
  end

  it "returns all items with same item id" do
    create_list(:invoice_item, 3)
    item = create(:item)
    create_list(:invoice_item, 3, item: item)

    get "/api/v1/invoice_items/find_all?item_id=#{item.id}"

    returned_item_invoices = JSON.parse(response.body)
    first_item = returned_item_invoices.first


    expect(response).to be_success
    expect(returned_item_invoices.count).to eq(3)
    expect(first_item["item_id"]).to eq(item.id)
  end

  it "returns all items with same invoice id" do
    create_list(:invoice_item, 3)
    invoice= create(:invoice)
    create_list(:invoice_item, 3, invoice: invoice)

    get "/api/v1/invoice_items/find_all?invoice_id=#{invoice.id}"

    returned_item_invoices = JSON.parse(response.body)
    first_invoice= returned_item_invoices.first


    expect(response).to be_success
    expect(returned_item_invoices.count).to eq(3)
    expect(first_invoice["invoice_id"]).to eq(invoice.id)
  end

   it "returns all invoice items with same quantity" do
    create_list(:invoice_item, 3)
    create_list(:invoice_item, 3, quantity: 123)

    get "/api/v1/invoice_items/find_all?quantity=123"

    returned_invoice_items = JSON.parse(response.body)
    first_invoice_item = returned_invoice_items.first


    expect(response).to be_success
    expect(returned_invoice_items.count).to eq(3)
    expect(first_invoice_item["quantity"]).to eq(123)
  end

   it "returns all invoice items with same unit price" do
    create_list(:invoice_item, 3)
    create_list(:invoice_item, 3, unit_price: 123)

    get "/api/v1/invoice_items/find_all?unit_price=123"

    returned_invoice_items = JSON.parse(response.body)
    first_invoice_item = returned_invoice_items.first


    expect(response).to be_success
    expect(returned_invoice_items.count).to eq(3)
    expect(first_invoice_item["unit_price"]).to eq(123)
  end

   it "returns all invoice items with same created_at" do
    create_list(:invoice_item, 3)

    get "/api/v1/invoice_items/find_all?created_at=2014-11-07T12:12:12.000Z"

    returned_invoice_items = JSON.parse(response.body)
    first_invoice_item = returned_invoice_items.first

    expect(response).to be_success
    expect(returned_invoice_items.count).to eq(3)
    expect(first_invoice_item["created_at"]).to eq("2014-11-07T12:12:12.000Z")
  end

  it "returns all invoice items with same updated_at" do
    create_list(:invoice_item, 3)

    get "/api/v1/invoice_items/find_all?updated_at=2014-11-07T12:12:12.000Z"

    returned_invoice_items = JSON.parse(response.body)
    first_invoice_item = returned_invoice_items.first

    expect(response).to be_success
    expect(returned_invoice_items.count).to eq(3)
    expect(first_invoice_item["updated_at"]).to eq("2014-11-07T12:12:12.000Z")
  end

  it "returns a random invoice item record" do
    create_list(:invoice_item, 3)
    get '/api/v1/invoice_items/random'

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.class).to eq(Hash)
  end

  it "returns associated invoice for a specific invoice item" do
    invoice = create(:invoice)
    invoice_item = create(:invoice_item, invoice_id: invoice.id)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

    returned_invoice = JSON.parse(response.body)
    expect(response).to be_success
    expect(returned_invoice["id"]).to eq(invoice.id)
    expect(returned_invoice.class).to eq(Hash)
  end

  it "returns associated item for a specific invoice item" do
    item = create(:item)
    invoice_item = create(:invoice_item, item_id: item.id)

    get "/api/v1/invoice_items/#{invoice_item.id}/item"

    returned_item = JSON.parse(response.body)
    expect(response).to be_success
    expect(returned_item["id"]).to eq(item.id)
    expect(returned_item.class).to eq(Hash)
  end
end
