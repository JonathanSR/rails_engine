class Api::V1::Items::ItemsMostItemsController < ApplicationController
  def index
    render json: Item.items_most_items_sold(params[:quantity])
  end
end
