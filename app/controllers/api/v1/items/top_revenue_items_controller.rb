class Api::V1::Items::TopRevenueItemsController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.top_by_revenue(params[:quantity]))
  end

end
