class StocksController < ApplicationController
  before_action :authorize!

  def new
    @stock = Stock.new
  end

  def create
    @stock = Stock.new(stock_params)

    if @stock.save
      @user_stock = UserStock.create!(stock_id: @stock.id, user_id: current_user.id)
      flash[:notice] = "Stock successfully added!"
      redirect_to stock_path(@stock.id)
    # else
    #   flash[:errors] = @stock.errors.full_messages.join(", ")
    #   redirect_to new_stock_path
    end
  end

  def index
    @stock_array = current_user.create_stock_array
  end

  def show
  end


  private

  def stock_params
    params.require(:stock).permit(:ticker)
  end
end
