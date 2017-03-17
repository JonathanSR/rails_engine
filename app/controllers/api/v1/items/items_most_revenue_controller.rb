class Api::V1::Items::ItemsMostRevenueController < ApplicationController
  def index
    render json: Item.items_most_revenue(params[:quantity])
  end
end
