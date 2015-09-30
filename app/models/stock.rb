class Stock < ActiveRecord::Base
  has_many :user_stocks
  has_many :users, through: :user_stocks

  def find_lt_trend(stock_change, spy_change)
    rel_performance = stock_change.to_f - spy_change

    one_yr_sp500_std_dev = 9.16    #source Morningstar, value as of 9/30/15
    limit_overvalued = 2 * one_yr_sp500_std_dev
    limit_somewhat_overvalued = 1 * one_yr_sp500_std_dev
    limit_somewhat_undervalued = -1 * one_yr_sp500_std_dev
    limit_undervalued = -2 * one_yr_sp500_std_dev

    if rel_performance > limit_overvalued
      "Overvalued"
    elsif rel_performance < limit_overvalued && rel_performance > limit_somewhat_overvalued
      "Somewhat overvalued"
    elsif rel_performance < limit_somewhat_overvalued && rel_performance > limit_somewhat_undervalued
      "Fairly valued"
    elsif rel_performance < limit_somewhat_undervalued && rel_performance > limit_undervalued
      "Somewhat undervalued"
    elsif rel_performance < limit_undervalued
      "Undervalued"
    end
  end

  def find_st_trend(stock_change, spy_change)
    rel_performance = stock_change.to_f - spy_change.to_f

    daily_sp500_std_dev = 0.98    #source Morningstar, value as of 9/30/15
    limit_hot = 2 * daily_sp500_std_dev
    limit_outperforming = 1 * daily_sp500_std_dev
    limit_underperforming = -1 * daily_sp500_std_dev
    limit_cold = -2 * daily_sp500_std_dev

    if rel_performance > limit_hot
      "HOT"
    elsif rel_performance < limit_hot && rel_performance > limit_outperforming
      "Outperforming"
    elsif rel_performance < limit_outperforming && rel_performance > limit_underperforming
      "Neutral"
    elsif rel_performance < limit_underperforming && rel_performance > limit_cold
      "Underperforming"
    elsif rel_performance < limit_cold
      "COLD"
    end
  end
end
