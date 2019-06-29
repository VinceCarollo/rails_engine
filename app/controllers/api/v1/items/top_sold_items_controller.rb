class Api::V1::Items::TopSoldItemsController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.top_by_amount_sold(params[:quantity]))
  end

end
