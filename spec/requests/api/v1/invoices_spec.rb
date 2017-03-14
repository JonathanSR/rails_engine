require 'rails_helper'

describe "Invoices API" do
  it "returns all invoices" do
   create(:customer)
  create(:merchant)
    create_list(:invoice, 3) #, merchant_id: merchant.id, customer_id: customer.id)
    # let(:merchant_id) {merchant.id}
    # let(:customer_id)

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
end

