class DropStocksUsersTable < ActiveRecord::Migration
  def change
    drop_table :stocks_users
  end
end
