class Api::V1::Merchants::MerchantsRevenueController < ApplicationController

  def index
    render json: Merchant.revenue_per_date(params[:quantity])
  end

end
