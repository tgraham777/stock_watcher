class AddQuantityPurchasePriceAndSpyPriceToUserStocksTable < ActiveRecord::Migration
  def change
    add_column :user_stocks, :quantity, :string
    add_column :user_stocks, :purchase_price, :string
    add_column :user_stocks, :spy_price, :string
  end
end
