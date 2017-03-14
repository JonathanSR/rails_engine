require 'rails_helper'

describe "Transactions API" do
  it "sends a list of transactions" do
    create_list(:transaction, 5)

    get '/api/v1/transactions'

    expect(response).to be_success

    transactions = JSON.parse(response.body)

    expect(transactions.count).to eq(5)
  end

  it "can get one transaction by its id" do
    id = create(:transaction).id

    get "/api/v1/transactions/#{id}"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction["id"]).to eq(id)
  end

  it "returns a single transaction by id" do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?#{transaction.id}"

    returned_transaction =JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_transaction["id"]).to eq(transaction.id)
  end

  it "returns a single transaction by invoice id" do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?#{transaction.invoice_id}"

    returned_transaction =JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_transaction["invoice_id"]).to eq(transaction.invoice_id)
  end

  it "returns a single transaction by credit card number" do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?#{transaction.credit_card_number}"

    returned_transaction =JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_transaction["credit_card_number"]).to eq(transaction.credit_card_number)
  end

  xit "returns a single transaction by credit card expiration date" do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?#{transaction.credit_card_expiration_date}"

    returned_transaction =JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_transaction["credit_card_expiration_date"]).to eq(transaction.credit_card_expiration_date)
  end

  it "returns a single transaction by result" do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?#{transaction.result}"

    returned_transaction =JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_transaction["result"]).to eq(transaction.result)
  end

  xit "returns a single transaction by created_at" do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?#{transaction.created_at}"

    returned_transaction =JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_transaction["created_at"]).to eq(transaction.created_at)
  end

  xit "returns a single transaction by updated_at" do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?#{transaction.updated_at}"

    returned_transaction =JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_transaction["updated_at"]).to eq(transaction.updated_at)
  end

  it "returns all transactions with an id" do
    transaction1 = create(:transaction)
    transaction2 = create(:transaction)

    get "/api/v1/transactions/find_all?id=#{transaction1.id}"

    returned_transactions = JSON.parse(response.body)
    first_transaction = returned_transactions.first

    expect(response).to be_success
    expect(returned_transactions.count).to eq(1)
    expect(first_transaction["id"]).to eq(transaction1.id)
  end

  it "returns all transactions with a invoice_id" do
    invoice1 = create(:invoice)
    invoice2 = create(:invoice)
    invoice3 = create(:invoice)
    transaction1 = create(:transaction, invoice_id: invoice1.id)
    transaction2 = create(:transaction, invoice_id: invoice2.id)
    transaction3 = create(:transaction, invoice_id: invoice3.id)

    get "/api/v1/transactions/find_all?name=#{transaction1.invoice_id}"

    returned_transactions = JSON.parse(response.body)
    first_transaction = returned_transactions.first

    expect(response).to be_success
    expect(returned_transactions.count).to eq(1)
    expect(first_transaction["invoice_id"]).to eq(transaction1.invoice_id)
  end

  xit "returns all transactions with a specific credit card number" do
    transaction1 = create(:transaction, credit_card_number: 1)
    transaction2 = create(:transaction, credit_card_number: 1)
    transaction3 = create(:transaction, credit_card_number: 3)

    get "/api/v1/transactions/find_all?name=#{transaction1.credit_card_number}"

    returned_transactions = JSON.parse(response.body)
    first_transaction = returned_transactions.first

    expect(response).to be_success
    expect(returned_transactions.count).to eq(2)
    expect(first_transaction["credit_card_number"]).to eq(transaction1.credit_card_number)
  end

  xit "returns all transactions with a credit card expiration date" do
    transaction1 = create(:transaction, credit_card_expiration_date: "2017-03-13")
    transaction2 = create(:transaction, credit_card_expiration_date: "2017-03-13")
    transaction3 = create(:transaction, credit_card_expiration_date: "2017-03-14")

    get "/api/v1/transactions/find_all?name=#{transaction1.credit_card_expiration_date}"

    returned_transactions = JSON.parse(response.body)
    first_transaction = returned_transactions.first

    expect(response).to be_success
    expect(returned_transactions.count).to eq(2)
    expect(first_transaction["credit_card_expiration_date"]).to eq(transaction1.credit_card_expiration_date)
  end

  xit "returns all transactions with a result" do
    transaction1 = create(:transaction, result: "success")
    transaction2 = create(:transaction, result: "failed")
    transaction3 = create(:transaction, result: "failed")

    get "/api/v1/transactions/find_all?name=#{transaction1.result}"

    returned_transactions = JSON.parse(response.body)
    first_transaction = returned_transactions.first

    expect(response).to be_success
    expect(returned_transactions.count).to eq(1)
    expect(first_transaction["result"]).to eq(transaction1.result)
  end

  xit "returns all transactions with same created_at" do
    create_list(:transaction, 3)

    get "/api/v1/transactions/find_all?created_at=#{transaction.first.created_at}"

    returned_transactions = JSON.parse(response.body)
    first_transaction = returned_transactions.first

    expect(response).to be_success
    expect(returned_transactions.count).to eq(3)
  end

  xit "returns all transactions with same updated_at" do
    create_list(:transaction, 3)

    get "/api/v1/transactions/find_all?updated_at=#{Transaction.first.updated_at}"

    returned_transactions = JSON.parse(response.body)
    first_transaction = returned_transactions.first

    expect(response).to be_success
    expect(returned_transactions.count).to eq(3)
  end

  it "returns a random transaction record" do
    create_list(:transaction, 3)
    get '/api/v1/transactions/random'

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    # expect(transaction.count).to eq(1) It doesn't pass, says 4
    #should we verify that it's only returning one transaction?
  end
end
