class Api::V1::Customers::SearchCustomersController < ApplicationController

  def index
    render json: Customer.where(customer_params)
  end

  def show
    render json: Customer.find_by(customer_params)
  end

  private

  def customer_params
    params.permit(:id, :customer_id, :merchant_id, :status, :created_at, :updated_at)
  end
end
