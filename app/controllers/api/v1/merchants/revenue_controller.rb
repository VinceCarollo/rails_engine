class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    limit = params[:quantity]
    render json: MerchantSerializer.new(Merchant.top_by_revenue(limit))
  end

  def show
    date = params[:date].to_datetime
    render json: MerchantSerializer.new(Transaction.revenue_on_date(date))
  end

end
