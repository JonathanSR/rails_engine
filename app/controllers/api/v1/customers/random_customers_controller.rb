class Api::V1::Customers::RandomCustomersController < ApplicationController
  def show
    render json: Customer.order("RANDOM()").first
  end
end
