class Api::V1::Merchants::MerchantsInvoicesController < ApplicationController
  def index
    merchant = Merchant.find(params[:id])
    render json: Invoice.where(merchant_id: merchant.id)
  end
end
