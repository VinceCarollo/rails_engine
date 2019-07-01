class Api::V1::Transactions::RandomController < ApplicationController

  def show
    ids = Transaction.pluck(:id).shuffle
    render json: TransactionSerializer.new(Transaction.find(ids[0]))
  end

end
