class Api::V1::Invoices::InvoicesCustomerController < ApplicationController

  def show
    render json: Invoice.find(params[:id]).customer
  end

end