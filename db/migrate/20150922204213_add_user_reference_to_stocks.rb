class AddUserReferenceToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :user_id, :integer, references: :users
  end
end
