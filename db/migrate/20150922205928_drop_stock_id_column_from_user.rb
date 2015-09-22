class DropStockIdColumnFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :stock_id
  end
end
