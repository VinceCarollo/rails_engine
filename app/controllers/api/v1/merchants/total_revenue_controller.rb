class Api::V1::Merchants::TotalRevenueController < ApplicationController

  def show
    if params[:date]
      render json: TotalRevenueSerializer.new(Merchant.find(params[:merchant_id]).total_revenue_by_date(params[:date]))
    else
      render json: TotalRevenueSerializer.new(Merchant.find(params[:merchant_id]).total_revenue)
    end
  end

end
