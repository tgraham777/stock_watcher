class AddShowPageDataColumnsToStockTable < ActiveRecord::Migration
  def change
    add_column :stocks, :spy_price_beg_yr, :string
    add_column :stocks, :spy_chg_ytd, :string
    add_column :stocks, :lt_trend, :string
    add_column :stocks, :spy_daily_pct_chg, :string
    add_column :stocks, :st_trend, :string
  end
end
