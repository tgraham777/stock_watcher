class DropStockIdFromUser < ActiveRecord::Migration
  def change
    remove_foreign_key :users, column: :stock_id
  end
end
