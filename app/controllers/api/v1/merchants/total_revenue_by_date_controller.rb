class Api::V1::Merchants::TotalRevenueByDateController < ApplicationController

  def show
    render json: Merchant.total_revenue_by_date(params[:date])
  end
end