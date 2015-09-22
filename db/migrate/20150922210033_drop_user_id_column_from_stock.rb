class DropUserIdColumnFromStock < ActiveRecord::Migration
  def change
    remove_column :stocks, :user_id
  end
end
