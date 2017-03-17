class Api::V1::Merchants::MerchantsTotalRevenueController < ApplicationController


  def index
    render json: Merchant.total_revenue(params[:date])
  end
  
  def show  
  render json:  Merchant.find(params[:id]), :serializer => MerchantRevenueSerializer, date: params[:date]
  end

end

GET /api/v1/merchants/:id/revenue?date=x