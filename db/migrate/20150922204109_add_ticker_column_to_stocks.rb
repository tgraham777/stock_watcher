class AddTickerColumnToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :ticker, :string
  end
end
