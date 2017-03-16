class Api::V1::Customers::CustomersInvoicesController < ApplicationController
  def index
    customer = Customer.find(params[:id])
    render json: Invoice.where(customer_id: customer.id)
  end
end
