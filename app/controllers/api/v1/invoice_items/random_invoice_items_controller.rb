class Api::V1::InvoiceItems::RandomInvoiceItemsController < ApplicationController

  def show
    render json: Invoice.order("RANDOM()").first
  end
end