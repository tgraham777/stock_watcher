class StocksController < ApplicationController
  before_action :authorize!

  def new
    @stock = Stock.new
  end

  def create
    # quote = StockQuoteRetrieverService.new.get_quote(stock_params[:ticker])
    # if quote[:Status] && quote[:Status] == "SUCCESS"
      @stock = Stock.new(stock_params)
      # @stock.name =
      # @stock.marketcap =

      @user_stock = UserStock.create!(stock_id: @stock.id, user_id: current_user.id)
      flash[:notice] = "Stock successfully added!"
      redirect_to stock_path(@stock.id)
    # else
    #   flash[:errors] = @stock.errors.full_messages.join(", ")
    #   redirect_to new_stock_path
    # end
  end

  def index
    @stock_array = current_user.create_stock_array
  end

  def show
    stock = Stock.find(params[:id])
    @stock_data = current_user.get_stock_data(stock.ticker)
  end


  private

  def stock_params
    params.require(:stock).permit(:ticker)
  end
end
