class Api::V1::Customers::CustomersTransactionsController < ApplicationController
  def index
    render json: Customer.find(params[:id]).transactions
  end
end
