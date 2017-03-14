class Api::V1::Transactions::RandomTransactionsController < ApplicationController

  def show
    render json: Transaction.order("RANDOM()").first
  end
end
