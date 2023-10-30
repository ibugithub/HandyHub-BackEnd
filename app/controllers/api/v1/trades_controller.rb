class Api::V1::TradesController < ApplicationController
  before_action :authenticate_user!, only: %i[create update destroy]

  def index
    @trades = Trade.all
    render json: @trades, status: :ok
  end

  def create
    trade_params = trade_params()

    @trade = Trade.new(trade_params)

    if @trade.save
      render json: @trade, status: :created
    else
      render json: @trade.errors, status: :unprocessable_entity
    end
  end

  def show
    @trade = Trade.find(params[:id])

    if @trade
      render json: @trade, status: :ok
    else
      render json: { error: 'Trade not found' }, status: :not_found
    end
  end

  def update
    @trade = Trade.find(params[:id])

    trade_params = trade_params()
    if @trade
      if @trade.update(trade_params)
        render json: @trade, status: :ok
      else
        render json: @trade.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'Trade not found' }, status: :not_found
    end
  end

  def destroy
    @trade = Trade.find(params[:id])

    if @trade
      @trade.destroy
      head :no_content
    else
      render json: { error: 'Trade not found' }, status: :not_found
    end
  end

  private

  def trade_params
    params.require(:trade).permit(:user_id, :name, :description, :image, :location, :price, :duration, :trade_type,
                                  :removed)
  end
end
