require 'rails_helper'

describe "Customers API" do
  it "sends a list of customers" do
    create_list(:customer, 5)

    get '/api/v1/customers'

    expect(response).to be_success

    customers = JSON.parse(response.body)

    expect(customers.count).to eq(5)
  end

  it "can get one customer by its id" do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer["id"]).to eq(id)
  end

  it "returns a single customer by id" do
    customer = create(:customer)

    get "/api/v1/customers/find?#{customer.id}"

    returned_customer =JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_customer["id"]).to eq(customer.id)
  end

  it "returns a single customer by first name" do
    customer = create(:customer)

    get "/api/v1/customers/find?#{customer.first_name}"

    returned_customer =JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_customer["first_name"]).to eq(customer.first_name)
  end

  it "returns a single customer by first name case insensitive" do
    customer = create(:customer, first_name: "Thomas")

    get "/api/v1/customers/find?thomas"

    returned_customer =JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_customer["first_name"]).to eq(customer.first_name)
  end

  it "returns a single customer by last name" do
    customer = create(:customer)

    get "/api/v1/customers/find?#{customer.last_name}"

    returned_customer =JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_customer["last_name"]).to eq(customer.last_name)
  end

  it "returns a single customer by last name case insensitive" do
    customer = create(:customer, last_name: "Torrent")

    get "/api/v1/customers/find?TORRENT"

    returned_customer =JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_customer["last_name"]).to eq(customer.last_name)
  end

  it "returns a single customer by created_at" do
    customer = create(:customer)

    get "/api/v1/customers/find?#{customer.created_at}"

    returned_customer =JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_customer["created_at"]).to eq("2014-11-07T12:12:12.000Z")
  end

  it "returns a single customer by updated_at" do
    customer = create(:customer)

    get "/api/v1/customers/find?#{customer.updated_at}"

    returned_customer =JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_customer["updated_at"]).to eq("2014-11-07T12:12:12.000Z")
  end

  it "returns all customers with an id" do
    customer1 = create(:customer)
    customer2 = create(:customer)

    get "/api/v1/customers/find_all?id=#{customer1.id}"

    returned_customers = JSON.parse(response.body)
    first_customer = returned_customers.first

    expect(response).to be_success
    expect(returned_customers.count).to eq(1)
    expect(first_customer["id"]).to eq(customer1.id)
  end

  it "returns all customers with a first name" do
    customer1 = create(:customer, first_name: "Maria", last_name: "Perez")
    customer2 = create(:customer, first_name: "Maria", last_name: "Martin")
    customer3 = create(:customer, first_name: "Diane", last_name: "Smith")

    get "/api/v1/customers/find_all?first_name=#{customer1.first_name}"

    returned_customers = JSON.parse(response.body)
    first_customer = returned_customers.first

    expect(response).to be_success
    expect(returned_customers.count).to eq(2)
    expect(first_customer["first_name"]).to eq(customer1.first_name)
  end

  it "returns all customers with a first name case insensitive" do
    customer1 = create(:customer, first_name: "Maria", last_name: "Perez")
    customer2 = create(:customer, first_name: "MariA", last_name: "Martin")

    get "/api/v1/customers/find_all?first_name=maria"

    returned_customers = JSON.parse(response.body)
    first_customer = returned_customers.first

    expect(response).to be_success
    expect(returned_customers.count).to eq(2)
    expect(first_customer["first_name"]).to eq(customer1.first_name)
  end

  it "returns all customers with a last name" do
    customer1 = create(:customer, first_name: "Maria", last_name: "Perez")
    customer2 = create(:customer, first_name: "James", last_name: "Higgs")
    customer3 = create(:customer, first_name: "Diane", last_name: "Perez")

    get "/api/v1/customers/find_all?last_name=#{customer1.last_name}"

    returned_customers = JSON.parse(response.body)
    first_customer = returned_customers.first

    expect(response).to be_success
    expect(returned_customers.count).to eq(2)
    expect(first_customer["last_name"]).to eq(customer1.last_name)
  end

  it "returns all customers with a last name case insensitive" do
    customer1 = create(:customer, first_name: "Maria", last_name: "Perez")
    customer3 = create(:customer, first_name: "Diane", last_name: "perez")

    get "/api/v1/customers/find_all?last_name=PEREZ"

    returned_customers = JSON.parse(response.body)
    first_customer = returned_customers.first

    expect(response).to be_success
    expect(returned_customers.count).to eq(2)
    expect(first_customer["last_name"]).to eq(customer1.last_name)
  end

  it "returns all customers with same created_at" do
    create_list(:customer, 3)

    get "/api/v1/customers/find_all?created_at=2014-11-07T12:12:12.000Z"


    returned_customers = JSON.parse(response.body)
    first_customer = returned_customers.first

    expect(response).to be_success
    expect(returned_customers.count).to eq(3)
  end

  it "returns all customers with same updated_at" do
    create_list(:customer, 3)

    get "/api/v1/customers/find_all?updated_at=2014-11-07T12:12:12.000Z"

    returned_customers = JSON.parse(response.body)
    first_customer = returned_customers.first

    expect(response).to be_success
    expect(returned_customers.count).to eq(3)
  end

  it "returns a random customer record" do
    create_list(:customer, 3)
    get '/api/v1/customers/random'

    returned_customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_customer.class).to eq(Hash)
  end
end
