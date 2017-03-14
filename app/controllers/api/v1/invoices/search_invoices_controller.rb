class Api::V1::Invoices::SearchInvoicesController < ApplicationController

  def show
    render json: Invoice.find_by(invoice_params)
  end

  private

  def invoice_params
    params.permit(:id, :customer_id, :merchant_id)
  end
end