require 'rails_helper'

describe "Invoices API" do
  it "returns all invoices" do
    create_list(:invoice, 3)

    get '/api/v1/invoices'

    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices.count).to eq(3)
  end

  it "can get a single invoice by its id" do
    id = create(:invoice).id

    get "/api/v1/invoices/#{id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["id"]).to eq(id)
  end

  it "returns a single invoice by customer_id" do
    invoice = create(:invoice)

    get "/api/v1/invoices/find?customer_id=#{invoice.customer_id}"

    returned_invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_invoice["customer_id"]).to eq(invoice.customer_id)
  end

  it "returns a single invoice by merchant_id" do
    invoice = create(:invoice)

    get "/api/v1/invoices/find?merchant_id=#{invoice.merchant_id}"

    returned_invoice =JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_invoice["merchant_id"]).to eq(invoice.merchant_id)
  end

  it "returns a single invoice by status" do
    invoice = create(:invoice)

    get "/api/v1/invoices/find?status=#{invoice.status}"

    returned_invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_invoice["status"]).to eq(invoice.status)
  end

  it "returns a single invoice by created_at" do
    invoice = create(:invoice, id: 732, created_at: "2014-11-07 12:12:12")

    get "/api/v1/invoices/find?created_at=2014-11-07 12:12:12"

    returned_invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_invoice["id"]).to eq(732)
  end

  it "returns a single invoice by updated_at" do
    invoice = create(:invoice, id: 734, created_at: "2014-11-07 12:12:12")

    get "/api/v1/invoices/find?updated_at=2014-11-07 12:12:12"

    returned_invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_invoice["id"]).to eq(734)
  end

  it "returns all invoices with same customer_id" do
    create_list(:invoice, 3)
    customer = create(:customer)
    create_list(:invoice, 3, customer: customer)

    get "/api/v1/invoices/find_all?customer_id=#{customer.id}"

    returned_invoices = JSON.parse(response.body)
    first_invoice = returned_invoices.first


    expect(response).to be_success
    expect(returned_invoices.count).to eq(3)
    expect(first_invoice["customer_id"]).to eq(customer.id)
  end

  it "returns all invoices with same merchant_id" do
    create_list(:invoice, 3)
    merchant = create(:merchant)
    create_list(:invoice, 3, merchant: merchant)

    get "/api/v1/invoices/find_all?merchant_id=#{merchant.id}"

    returned_invoices = JSON.parse(response.body)
    first_invoice = returned_invoices.first


    expect(response).to be_success
    expect(returned_invoices.count).to eq(3)
    expect(first_invoice["merchant_id"]).to eq(merchant.id)
  end

  it "returns all invoices with same status" do
    create_list(:invoice, 3)
    create_list(:invoice, 3, status: "ordered")

    get "/api/v1/invoices/find_all?status=ordered"

    returned_invoices = JSON.parse(response.body)
    first_invoice = returned_invoices.first


    expect(response).to be_success
    expect(returned_invoices.count).to eq(3)
    expect(first_invoice["status"]).to eq("ordered")
  end

  it "returns all invoices with same created_at" do
    invoice1 = create(:invoice, id: 860, created_at: "2014-11-07 12:12:12")
    invoice2 = create(:invoice, id: 861, created_at: "2014-11-07 12:12:12")
    invoice3 = create(:invoice, id: 862, created_at: "2014-11-07 12:12:12")

    get "/api/v1/invoices/find_all?created_at=2014-11-07 12:12:12"

    returned_invoices = JSON.parse(response.body)
    first_invoice = returned_invoices.first

    expect(response).to be_success
    expect(returned_invoices.count).to eq(3)
    expect(first_invoice["id"]).to eq(860)
  end

  it "returns all invoices with same updated_at" do
    invoice1 = create(:invoice, id: 850, created_at: "2014-11-07 12:12:12")
    invoice2 = create(:invoice, id: 851, created_at: "2014-11-07 12:12:12")
    invoice3 = create(:invoice, id: 852, created_at: "2014-11-07 12:12:12")

    get "/api/v1/invoices/find_all?updated_at=2014-11-07 12:12:12"

    returned_invoices = JSON.parse(response.body)
    first_invoice = returned_invoices.first

    expect(response).to be_success
    expect(returned_invoices.count).to eq(3)
    expect(first_invoice["id"]).to eq(850)
  end

  it "returns a random invoice record" do
    create_list(:invoice, 3)
    get '/api/v1/invoices/random'

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice.class).to eq(Hash)
  end

  it "returns all transactions associated with a specific invoice" do
    create_list(:invoice_with_transactions, 3)

    get "/api/v1/invoices/#{Invoice.first.id}/transactions"

    invoice = JSON.parse(response.body)
    expect(response).to be_success
    expect(invoice.first["invoice_id"]).to eq(Invoice.first.id)
    expect(Invoice.first.transactions.count).to eq(3)
  end

  it "returns all invoice items associated with a specific invoice" do
    create_list(:invoice_with_invoice_items, 3)

    get "/api/v1/invoices/#{Invoice.first.id}/invoice_items"

    transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(transactions.first["invoice_id"]).to eq(Invoice.first.id)
    expect(Invoice.first.invoice_items.count).to eq(3)
  end

  it "returns all associated items with a specific invoice" do
    create_list(:invoice_with_invoice_items, 3)

    get "/api/v1/invoices/#{Invoice.first.id}/items"

    invoice = JSON.parse(response.body)
    expect(response).to be_success
    expect(invoice.count).to eq(3)
  end

  it "returns the associated customer" do
    create_list(:invoice, 3)
    customer = create(:customer)
    create(:invoice, customer: customer)

    get "/api/v1/invoices/#{Invoice.last.id}/customer"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["id"]).to eq(Invoice.last.customer.id)
  end

  it "returns the associated merchant" do
    create_list(:invoice, 3)
    merchant = create(:merchant)
    create(:invoice, merchant: merchant)

    get "/api/v1/invoices/#{Invoice.last.id}/merchant"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["id"]).to eq(Invoice.last.merchant.id)
  end

  it "returns all invoice items associated with a specific item" do
    item = create(:item)
    create_list(:invoice_item, 3, item_id: item.id)

    get "/api/v1/items/#{item.id}/invoice_items"

    invoice_items= JSON.parse(response.body)
    expect(response).to be_success
    expect(invoice_items.first["item_id"]).to eq(item.id)
    expect(invoice_items.count).to eq(3)
  end

  it "returns associated merchand of a specific item" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}/merchant"

    returned_merchant= JSON.parse(response.body)
    expect(response).to be_success
    expect(returned_merchant["id"]).to eq(merchant.id)
    expect(returned_merchant.class).to eq(Hash)
  end
end
