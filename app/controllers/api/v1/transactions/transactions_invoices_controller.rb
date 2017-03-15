class Api::V1::Transactions::TransactionsInvoicesController < ApplicationController
  def show
    transaction = Transaction.find(params[:id])
    render json: transaction.invoice.as_json(only: [:id, :customer_id, :merchant_id])
  end
end
