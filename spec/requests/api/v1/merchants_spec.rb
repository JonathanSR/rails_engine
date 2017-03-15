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
end
