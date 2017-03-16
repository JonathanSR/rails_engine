class Api::V1::Items::ItemsMerchantsController < ApplicationController
  def show
    item = Item.find(params[:id])
    render json: item.merchant
  end
end
