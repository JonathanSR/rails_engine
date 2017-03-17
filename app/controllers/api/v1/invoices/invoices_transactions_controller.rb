class Api::V1::Invoices::InvoicesTransactionsController < ApplicationController
  def index
    render json: Invoice.find(params[:id]).transactions
  end
end
