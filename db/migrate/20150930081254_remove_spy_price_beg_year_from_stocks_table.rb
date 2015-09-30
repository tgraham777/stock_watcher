class RemoveSpyPriceBegYearFromStocksTable < ActiveRecord::Migration
  def change
    remove_column :stocks, :spy_price_beg_yr, :string
  end
end
