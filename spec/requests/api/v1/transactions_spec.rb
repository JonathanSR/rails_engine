require 'rails_helper'

describe "Transactions API" do
  it "sends a list of transactions" do
    create_list(:transaction, 5)

    get '/api/v1/transactions'

    transactions = JSON.parse(response.body)
    expect(response).to be_success
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

  it "returns a single transaction by credit card expiration date" do
    transaction = create(:transaction, id: 120, credit_card_expiration_date: "2014-11-07 12:12:12")

    get "/api/v1/transactions/find?2014-11-07 12:12:12"

    returned_transaction =JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_transaction["id"]).to eq(120)
  end

  it "returns a single transaction by result" do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?#{transaction.result}"

    returned_transaction =JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_transaction["result"]).to eq(transaction.result)
  end

  it "returns a single transaction by result case insensitive" do
    transaction = create(:transaction, result: "failed")

    get "/api/v1/transactions/find?FAILED"

    returned_transaction =JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_transaction["result"]).to eq(transaction.result)
  end

  it "returns a single transaction by created_at" do
    transaction = create(:transaction, id: 532, created_at: "2017-03-13")

    get "/api/v1/transactions/find?created_at=2017-03-13"

    returned_transaction =JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_transaction["id"]).to eq(532)
  end

  it "returns a single transaction by updated_at" do
    transaction = create(:transaction, id: 110, credit_card_expiration_date: "2014-11-07 12:12:12")

    get "/api/v1/transactions/find?2014-11-07 12:12:12"

    returned_transaction =JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_transaction["id"]).to eq(110)
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

  it "returns all transactions with an invoice_id" do
      create_list(:transaction, 3)
      invoice = create(:invoice)
      create_list(:transaction, 3, invoice: invoice)

    get "/api/v1/transactions/find_all?invoice_id=#{invoice.id}"

    returned_transactions = JSON.parse(response.body)
    first_transaction = returned_transactions.first

    expect(response).to be_success
    expect(returned_transactions.count).to eq(3)
    expect(first_transaction["invoice_id"]).to eq(invoice.id)
  end

  it "returns all transactions with a specific credit card number" do
    transaction1 = create(:transaction, credit_card_number: 1)
    transaction2 = create(:transaction, credit_card_number: 1)
    transaction3 = create(:transaction, credit_card_number: 3)

    get "/api/v1/transactions/find_all?credit_card_number=#{transaction1.credit_card_number}"

    returned_transactions = JSON.parse(response.body)
    first_transaction = returned_transactions.first

    expect(response).to be_success
    expect(returned_transactions.count).to eq(2)
    expect(first_transaction["credit_card_number"]).to eq(transaction1.credit_card_number)
  end

  it "returns all transactions with a credit card expiration date" do
    transaction1 = create(:transaction, id: 423, credit_card_expiration_date: "2017-03-13")
    transaction2 = create(:transaction, id: 424, credit_card_expiration_date: "2017-03-13")
    transaction3 = create(:transaction, id: 425, credit_card_expiration_date: "2017-03-14")

    get "/api/v1/transactions/find_all?credit_card_expiration_date=2017-03-13"

    returned_transactions = JSON.parse(response.body)
    first_transaction = returned_transactions.first

    expect(response).to be_success
    expect(returned_transactions.count).to eq(2)
    expect(first_transaction["id"]).to eq(423)
  end

  it "returns all transactions with a result" do
    transaction1 = create(:transaction, result: "success")
    transaction2 = create(:transaction, result: "failed")
    transaction3 = create(:transaction, result: "failed")

    get "/api/v1/transactions/find_all?result=#{transaction2.result}"

    returned_transactions = JSON.parse(response.body)
    first_transaction = returned_transactions.first

    expect(response).to be_success
    expect(returned_transactions.count).to eq(2)
    expect(first_transaction["result"]).to eq("failed")
  end

  it "returns all transactions with a result case insensitive" do
    transaction1 = create(:transaction, result: "success")
    transaction2 = create(:transaction, result: "success")
    transaction3 = create(:transaction, result: "failed")

    get "/api/v1/transactions/find_all?result=SUCCESS"

    returned_transactions = JSON.parse(response.body)
    first_transaction = returned_transactions.first

    expect(response).to be_success
    expect(returned_transactions.count).to eq(2)
    expect(first_transaction["result"]).to eq("success")
  end

  it "returns all transactions with same created_at" do
    transaction1 = create(:transaction, id: 223, created_at: "2017-03-13")
    transaction2 = create(:transaction, id: 224, created_at: "2017-03-13")
    transaction3 = create(:transaction, id: 225, created_at: "2017-03-14")

    get "/api/v1/transactions/find_all?created_at=2017-03-13"

    returned_transactions = JSON.parse(response.body)
    first_transaction = returned_transactions.first

    expect(response).to be_success
    expect(returned_transactions.count).to eq(2)
    expect(first_transaction["id"]).to eq(223)
  end

  it "returns all transactions with same updated_at" do
    transaction1 = create(:transaction, id: 410, updated_at: "2017-03-13")
    transaction2 = create(:transaction, id: 411, updated_at: "2017-03-13")
    transaction3 = create(:transaction, id: 412, updated_at: "2017-03-13")

    get "/api/v1/transactions/find_all?updated_at=2017-03-13"

    returned_transactions = JSON.parse(response.body)
    first_transaction = returned_transactions.first

    expect(response).to be_success
    expect(returned_transactions.count).to eq(3)
    expect(first_transaction["id"]).to eq(410)
  end

  it "returns a random transaction record" do
    create_list(:transaction, 3)
    get '/api/v1/transactions/random'

    returned_transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(returned_transaction.class).to eq(Hash)
  end

  it "returns associated invoice of a specific transaction" do
    invoice = create(:invoice)
    transaction = create(:transaction, invoice_id: invoice.id)

    get "/api/v1/transactions/#{transaction.id}/invoice"

    returned_invoice = JSON.parse(response.body)
    expect(response).to be_success
    expect(returned_invoice["id"]).to eq(invoice.id)
    expect(returned_invoice.class).to eq(Hash)
  end
end
