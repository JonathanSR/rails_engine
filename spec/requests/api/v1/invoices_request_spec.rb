require 'rails_helper'

describe "Invoices API" do
  it "sends a list of invoices" do
    create_list(:merchant, 5)

    get '/api/v1/invoices'

    expect(response).to be_success
  end
end
