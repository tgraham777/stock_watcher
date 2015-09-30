class AddPurchasedColumnToUserStocksTable < ActiveRecord::Migration
  def change
    add_column :user_stocks, :purchased, :boolean, default: false
  end
end
