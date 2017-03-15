class Api::V1::InvoiceItems::InvoiceItemsInvoicesController < ApplicationController
  def show
    invoice_item = InvoiceItem.find(params[:id])
    render json: invoice_item.invoice.as_json(only: [:id, :customer_id, :merchant_id])
  end
end
