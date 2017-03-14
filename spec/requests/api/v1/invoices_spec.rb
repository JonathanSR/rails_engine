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
    invoice = create(:invoice)

    get "/api/v1/invoices/find?created_at=2014-11-07 12:12:12"

    returned_invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_invoice["created_at"]).to eq("2014-11-07T12:12:12.000Z")
  end

  it "returns a single invoice by updated_at" do
    invoice = create(:invoice)

    get "/api/v1/invoices/find?updated_at=2014-11-07T12:12:12.000Z"

    returned_invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_invoice["created_at"]).to eq("2014-11-07T12:12:12.000Z")
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
    create_list(:invoice, 3)

    get "/api/v1/invoices/find_all?created_at=2014-11-07T12:12:12.000Z"

    returned_invoices = JSON.parse(response.body)
    first_invoice = returned_invoices.first

    expect(response).to be_success
    expect(returned_invoices.count).to eq(3)
    expect(first_invoice["created_at"]).to eq("2014-11-07T12:12:12.000Z")
    
  end

  it "returns all invoices with same updated_at" do
    create_list(:invoice, 3)

    get "/api/v1/invoices/find_all?updated_at=2014-11-07T12:12:12.000Z"

    returned_invoices = JSON.parse(response.body)
    first_invoice = returned_invoices.first

    expect(response).to be_success
    expect(returned_invoices.count).to eq(3)
    expect(first_invoice["created_at"]).to eq("2014-11-07T12:12:12.000Z")
    
  end

  it "returns a random invoice record" do
    create_list(:invoice, 3)
    get '/api/v1/invoices/random'

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice.class).to eq(Hash)
  end
end
