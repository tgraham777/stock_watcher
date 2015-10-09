class StocksController < ApplicationController
  before_action :authorize!

  def new
    @stock = Stock.new
  end

  def create
    stock_data = StockQuoteRetrieverService.new.get_quote(stock_params[:ticker])
    if stock_data[:Status] && stock_data[:Status] == "SUCCESS"
      set_new_stock(stock_data)
      flash[:success] = "#{stock_data[:Name]} successfully added!"
      redirect_to stock_path(@stock.id)
    else
      @stock = Stock.new
      flash[:error] = stock_data[:Message]
      render :new
    end
  end

  def index
    @stocks = current_user.stocks
  end

  def show
    @stock = Stock.find_by(id: params[:id])
    @user_stock = UserStock.find_by(user_id: current_user.id, stock_id: @stock.id)
  end

  def update
    @stock = Stock.find_by(id: params[:id])
    stock_data = StockQuoteRetrieverService.new.get_quote(@stock.ticker)
    update_stock(stock_data)

    flash[:success] = "#{stock_data[:Name]} successfully updated!"
    redirect_to stock_path(@stock.id)
  end

  def destroy
    @stock = Stock.find_by(id: params[:id])
    UserStock.find_by(user_id: current_user.id, stock_id: @stock.id).destroy

    flash[:success] = "#{@stock.name} successfully removed!"
    redirect_to stocks_path
  end


  private

  def stock_params
    params.require(:stock).permit(:ticker)
  end

  def set_new_stock(stock_data)
    spy_change = UserStock.find_change_ytd
    lt_trend = Stock.find_lt_trend(stock_data[:ChangePercentYTD], spy_change)
    spy_daily_pct_chg = FinanceScraper.find_spy_daily_percent_change
    st_trend = Stock.find_st_trend(stock_data[:ChangePercent], FinanceScraper.find_spy_daily_percent_change)
    sw_analysis = Stock.overall_trend(lt_trend, st_trend)

    @stock = Stock.create!(
      ticker: stock_data[:Symbol],
      name: stock_data[:Name],
      last_price: stock_data[:LastPrice],
      change: stock_data[:Change],
      change_percent: stock_data[:ChangePercent],
      timestamp: stock_data[:Timestamp],
      market_cap: stock_data[:MarketCap],
      volume: stock_data[:Volume],
      start_value_ytd: stock_data[:ChangeYTD],
      change_ytd: stock_data[:ChangePercentYTD],
      high: stock_data[:High],
      low: stock_data[:Low],
      open: stock_data[:Open],
      spy_chg_ytd: spy_change,
      lt_trend: lt_trend,
      spy_daily_pct_chg: spy_daily_pct_chg,
      st_trend: st_trend,
      recommendation: sw_analysis
    )

    UserStock.create!(stock_id: @stock.id, user_id: current_user.id)
  end

  def update_stock(stock_data)
    spy_change = UserStock.find_change_ytd
    lt_trend = Stock.find_lt_trend(stock_data[:ChangePercentYTD], spy_change)
    spy_daily_pct_chg = FinanceScraper.find_spy_daily_percent_change
    st_trend = Stock.find_st_trend(stock_data[:ChangePercent], FinanceScraper.find_spy_daily_percent_change)
    sw_analysis = Stock.overall_trend(lt_trend, st_trend)

    @stock.update_attributes(
      ticker: stock_data[:Symbol],
      name: stock_data[:Name],
      last_price: stock_data[:LastPrice],
      change: stock_data[:Change],
      change_percent: stock_data[:ChangePercent],
      timestamp: stock_data[:Timestamp],
      market_cap: stock_data[:MarketCap],
      volume: stock_data[:Volume],
      start_value_ytd: stock_data[:ChangeYTD],
      change_ytd: stock_data[:ChangePercentYTD],
      high: stock_data[:High],
      low: stock_data[:Low],
      open: stock_data[:Open],
      spy_chg_ytd: spy_change,
      lt_trend: lt_trend,
      spy_daily_pct_chg: spy_daily_pct_chg,
      st_trend: st_trend,
      recommendation: sw_analysis
    )
  end
end
