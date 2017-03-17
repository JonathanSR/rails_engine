class Api::V1::Merchants::MerchantsRevenueController < ApplicationController
  def index
      render json: Merchant.total_revenue(params[:date]), serializer: MerchantsRevenueSerializer
  end
end
