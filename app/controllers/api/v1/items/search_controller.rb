class Api::V1::Items::SearchController < ApplicationController

  def show
    if params[:name]
      render json: ItemSerializer.new(Item.find_by(name: params[:name]))
    elsif params[:id]
      render json: ItemSerializer.new(Item.find(params[:id]))
    elsif params[:created_at]
      render json: ItemSerializer.new(Item.find_by(created_at: params[:created_at]))
    elsif params[:updated_at]
      render json: ItemSerializer.new(Item.find_by(updated_at: params[:updated_at]))
    elsif params[:merchant_id]
      render json: ItemSerializer.new(Item.find_by(merchant_id: params[:merchant_id]))
    elsif params[:unit_price]
      render json: ItemSerializer.new(Item.find_by(unit_price: params[:unit_price]))
    elsif params[:description]
      render json: ItemSerializer.new(Item.find_by(description: params[:description]))
    else
      render json: ItemSerializer.new(Item.random)
    end
  end

  def index
    if params[:id]
      render json: ItemSerializer.new(Item.where(id: params[:id]))
    elsif params[:name]
      render json: ItemSerializer.new(Item.where(name: params[:name]))
    elsif params[:created_at]
      render json: ItemSerializer.new(Item.where(created_at: params[:created_at]))
    elsif params[:updated_at]
      render json: ItemSerializer.new(Item.where(updated_at: params[:updated_at]))
    elsif params[:merchant_id]
      render json: ItemSerializer.new(Item.where(merchant_id: params[:merchant_id]).reverse)
    elsif params[:unit_price]
      render json: ItemSerializer.new(Item.where(unit_price: params[:unit_price]))
    elsif params[:description]
      render json: ItemSerializer.new(Item.where(description: params[:description]))
    end
  end

end
