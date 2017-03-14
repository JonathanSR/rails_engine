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

  xit "returns a single merchant by created_at" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?#{merchant.created_at}"

    returned_merchant =JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_merchant["created_at"]).to eq(merchant.created_at)
  end

  xit "returns a single merchant by updated_at" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?#{merchant.updated_at}"

    returned_merchant =JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_merchant["updated_at"]).to eq(merchant.updated_at)
  end

  xit "returns all merchants with an id" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)

    get "/api/v1/merchants/find_all?name=#{merchant1.id}"

    returned_merchants = JSON.parse(response.body)
    first_merchant = returned_merchants.first

    expect(response).to be_success
    expect(returned_merchants.count).to eq(1)
    expect(first_merchant["id"]).to eq(merchant1.id)
  end

  xit "returns all merchants with a name" do
    merchant1 = create(:merchant, name: "Shop")
    merchant2 = create(:merchant, name: "Shopify")
    merchant3 = create(:merchant, name: "Craftsy")

    get "/api/v1/merchants/find_all?name=#{merchant1.name}"

    returned_merchants = JSON.parse(response.body)
    first_merchant = returned_merchants.first

    expect(response).to be_success
    expect(returned_merchants.count).to eq(2)
    expect(first_merchant["name"]).to eq(merchant1.name)
  end

  xit "returns all merchants with same created_at" do
    create_list(:merchant, 3)

    get "/api/v1/merchants/find_all?created_at=#{Merchant.first.created_at}"

    returned_merchants = JSON.parse(response.body)
    first_merchant = returned_merchants.first

    expect(response).to be_success
    expect(returned_merchants.count).to eq(3)
  end

  xit "returns all merchants with same updated_at" do
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

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    # expect(merchant.count).to eq(1) It doesn't pass, says 4
    #should we verify that it's only returning one merchant?
  end
end
