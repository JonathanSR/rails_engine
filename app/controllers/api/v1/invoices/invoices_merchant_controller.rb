class Api::V1::Invoices::InvoicesMerchantController < ApplicationController
  def show
    render json: Invoice.find(params[:id]).merchant
  end
end
