class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    limit = params[:quantity]
    render json: MerchantSerializer.new(Merchant.top_by_revenue(limit))
  end

  def show
    date = params[:date]
    render json: RevenueSerializer.new(Transaction.revenue_on_date(date))
  end

end
