class Api::V1::Items::ItemsInvoiceItemsController < ApplicationController
  def index
    item = Item.find(params[:id])
    render json: InvoiceItem.where(item_id: item.id)
  end
end
