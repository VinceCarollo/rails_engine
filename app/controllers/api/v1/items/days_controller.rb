class Api::V1::Items::DaysController < ApplicationController

  def show
    render json: DaySerializer.new(Item.find(params[:item_id]).best_day)
  end

end
