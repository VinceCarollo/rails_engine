class Api::V1::Merchants::SearchController < ApplicationController

  def show
    if params[:name]
      render json: MerchantSerializer.new(Merchant.find_by(name: params[:name]))
    elsif params[:id]
      render json: MerchantSerializer.new(Merchant.find(params[:id]))
    elsif params[:created_at]
      selected_date = params[:created_at].to_datetime
      render json: MerchantSerializer.new(Merchant.find_by_created_at(selected_date))
    elsif params[:updated_at]
      selected_date = params[:updated_at].to_datetime
      render json: MerchantSerializer.new(Merchant.find_by_updated_at(selected_date))
    else
      render json: MerchantSerializer.new(Merchant.random)
    end
  end

  def index
    if params[:name]
      render json: MerchantSerializer.new(Merchant.find_all_by_name(params[:name]))
    elsif params[:id]
      render json: MerchantSerializer.new(Merchant.find_all_by_id(params[:id]))
    elsif params[:created_at]
      render json: MerchantSerializer.new(Merchant.find_all_by_created_at(params[:created_at].to_datetime))
    elsif params[:updated_at]
      render json: MerchantSerializer.new(Merchant.find_all_by_updated_at(params[:updated_at].to_datetime))
    end
  end

end
