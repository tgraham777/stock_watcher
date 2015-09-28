class AddDataColumnsToStockTable < ActiveRecord::Migration
  def change
    add_column :stocks, :name, :string
    add_column :stocks, :last_price, :string
    add_column :stocks, :change, :string
    add_column :stocks, :change_percent, :string
    add_column :stocks, :timestamp, :string
    add_column :stocks, :market_cap, :string
    add_column :stocks, :volume, :string
    add_column :stocks, :start_value_ytd, :string
    add_column :stocks, :change_ytd, :string
    add_column :stocks, :high, :string
    add_column :stocks, :low, :string
    add_column :stocks, :open, :string
  end
end
