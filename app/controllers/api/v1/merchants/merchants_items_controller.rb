class Api::V1::Merchants::MerchantsItemsController < ApplicationController
  def index
    merchant = Merchant.find(params[:id])
    render json: Item.where(merchant_id: merchant.id)
  end
end
