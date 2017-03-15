class Api::V1::Items::RandomItemsController < ApplicationController

  def show
    render json: Item.order("RANDOM()").first
  end
end