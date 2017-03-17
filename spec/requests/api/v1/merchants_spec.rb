require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 5)

    get '/api/v1/merchants'

    expect(response).to be_success

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(5)
  end

  it "can get one merchant by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["id"]).to eq(id)
  end

  it "returns a single merchant by id" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?#{merchant.id}"

    returned_merchant =JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_merchant["id"]).to eq(merchant.id)
  end

  it "returns a single merchant by name" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?#{merchant.name}"

    returned_merchant =JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_merchant["name"]).to eq(merchant.name)
  end

  it "returns a single merchant by name case insensitive" do
    merchant = create(:merchant, name: "Safeway")

    get "/api/v1/merchants/find?safeway"

    returned_merchant =JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_merchant["name"]).to eq(merchant.name)
  end

  it "returns a single merchant by created_at" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?#{merchant.created_at}"

    returned_merchant =JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_merchant["created_at"]).to eq("2014-11-07T12:12:12.000Z")
  end

  it "returns a single merchant by updated_at" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?#{merchant.updated_at}"

    returned_merchant =JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_merchant["updated_at"]).to eq("2014-11-07T12:12:12.000Z")
  end

  it "returns all merchants with an id" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)

    get "/api/v1/merchants/find_all?id=#{merchant1.id}"

    returned_merchants = JSON.parse(response.body)
    first_merchant = returned_merchants.first

    expect(response).to be_success
    expect(returned_merchants.count).to eq(1)
    expect(first_merchant["id"]).to eq(merchant1.id)
  end

  it "returns all merchants with a name" do
    merchant1 = create(:merchant, name: "Google")
    merchant2 = create(:merchant, name: "Amazon")
    merchant3 = create(:merchant, name: "Craftsy")

    get "/api/v1/merchants/find_all?name=#{merchant1.name}"

    returned_merchants = JSON.parse(response.body)
    first_merchant = returned_merchants.first

    expect(response).to be_success
    expect(returned_merchants.count).to eq(1)
    expect(first_merchant["name"]).to eq(merchant1.name)
  end

  it "returns all merchants with a name case insensitive" do
    merchant1 = create(:merchant, name: "Google")
    merchant2 = create(:merchant, name: "Amazon")
    merchant3 = create(:merchant, name: "Craftsy")

    get "/api/v1/merchants/find_all?name=AMAZON"

    returned_merchants = JSON.parse(response.body)
    first_merchant = returned_merchants.first

    expect(response).to be_success
    expect(returned_merchants.count).to eq(1)
    expect(first_merchant["name"]).to eq("Amazon")
  end

  it "returns all merchants with same created_at" do
    create_list(:merchant, 3)

    get "/api/v1/merchants/find_all?created_at=#{Merchant.first.created_at}"

    returned_merchants = JSON.parse(response.body)
    first_merchant = returned_merchants.first

    expect(response).to be_success
    expect(returned_merchants.count).to eq(3)
  end

  it "returns all merchants with same updated_at" do
    create_list(:merchant, 3)

    get "/api/v1/merchants/find_all?updated_at=#{Merchant.first.updated_at}"

    returned_merchants = JSON.parse(response.body)
    first_merchant = returned_merchants.first

    expect(response).to be_success
    expect(returned_merchants.count).to eq(3)
  end

  it "returns a random merchant record" do
    create_list(:merchant, 3)
    get '/api/v1/merchants/random'

    returned_merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_merchant.class).to eq(Hash)
  end

  # it "returns customers_with_pending_invoices" do
  #   create(:merchant)
  #   create(:)
  #   create_list(:invoices, 3 merchant: merchant)

  #   get "/api/v1/merchants/:id/customers_with_pending_invoices"

  #   merchant = JSON.parse(response.body)

  #   expect(response).to be_success

  it "returns merchants favorite customer" do
    merchant = create(:merchant)
    customer_one = create(:customer)
    customer_two = create(:customer)
    invoice_one = create(:invoice, merchant: merchant, customer: customer_one)
    invoice_two = create(:invoice, merchant: merchant, customer: customer_two)
    invoice_three = create(:invoice, merchant: merchant, customer: customer_one)
    create(:transaction, result: 'success', invoice: invoice_one)
    create(:transaction, result: 'success', invoice: invoice_two)
    create(:transaction, result: 'success', invoice: invoice_three)

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"

    favorite_customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(favorite_customer["id"]).to eq(customer_one.id)
  end

  it "returns the top merchant(s) by revenue" do
    merchant_one = create(:merchant)
    merchant_two = create(:merchant)
    invoice_one = create(:invoice, merchant: merchant_one)
    invoice_two = create(:invoice, merchant: merchant_one)
    invoice_three = create(:invoice, merchant: merchant_two)
    invoice_four = create(:invoice, merchant: merchant_two)
    Invoice.all.each do |invoice|
      create(:invoice_item, quantity:1, unit_price: 10, invoice: invoice)
    end

    InvoiceItem.all.each do |invoice_item|
      create(:transaction, result: "success", invoice: invoice_item.invoice)
    end

    get "/api/v1/merchants/most_revenue?quantity=1"

    top_merchants = JSON.parse(response.body)

    expect(response).to be_success
    expect(top_merchants.first["id"]).to eq(merchant_one.id)
  end

  it "returns all items associated with a specific merchant" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/items"

    items = JSON.parse(response.body)
    expect(response).to be_success
    expect(items.first["merchant_id"]).to eq(merchant.id)
    expect(merchant.items.count).to eq(3)
  end

  it "returns all invoices associated with a specific merchant" do
    merchant = create(:merchant)
    create_list(:invoice, 3, merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/invoices"

    invoices = JSON.parse(response.body)
    expect(response).to be_success
    expect(invoices.first["merchant_id"]).to eq(merchant.id)
    expect(merchant.invoices.count).to eq(3)
  end

  it "returns revenue of all merchants on a date" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    invoice1 = create(:invoice, merchant_id: merchant1.id)
    invoice2 = create(:invoice, merchant_id: merchant2.id)
    invoice_item1 = create(:invoice_item, invoice_id: invoice1.id, quantity: 2, unit_price: 50)
    invoice_item2 = create(:invoice_item, invoice_id: invoice2.id, quantity: 1, unit_price: 50)
    transaction1 = create(:transaction, result: 'success', invoice_id: invoice1.id, created_at: "2014-11-07")
    transaction2 = create(:transaction, result: 'success', invoice_id: invoice2.id, created_at: "2014-11-07")

    get "/api/v1/merchants/revenue=2014-11-07"

    returned_result = JSON.parse(response.body)
    byebug
    expect(response).to be_success
    expect(returned_result).to have_key('total_revenue')
    expect(returned_result['total_revenue']).to eq(150)
  end
end
