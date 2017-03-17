class Api::V1::Transactions::TransactionsInvoicesController < ApplicationController
  def show
    transaction = Transaction.find(params[:id])
    render json: transaction.invoice
  end
end
