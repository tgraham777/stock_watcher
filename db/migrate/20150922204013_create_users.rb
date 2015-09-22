class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.references :stock, index: true, foreign_key: true
    end
  end
end
