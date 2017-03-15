class Api::V1::InvoiceItems::InvoiceItemsItemsController < ApplicationController
  def show
    invoice_item = InvoiceItem.find(params[:id])
    render json: invoice_item.item.as_json(only: [:customer_id, :merchant_id])
  end
end
