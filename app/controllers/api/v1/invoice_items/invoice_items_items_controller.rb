class Api::V1::InvoiceItems::InvoiceItemsItemsController < ApplicationController
  def show
    invoice_item = InvoiceItem.find(params[:id])
    render json: invoice_item.item
  end
end
