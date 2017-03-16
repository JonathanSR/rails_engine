class Api::V1::Invoices::InvoicesItemsController < ApplicationController
  def index
    render json: Invoice.find(params[:id]).items
  end
end
