class Api::V1::Invoices::RandomInvoicesController < ApplicationController
  def show
    render json: Invoice.order("RANDOM()").first
  end
end
