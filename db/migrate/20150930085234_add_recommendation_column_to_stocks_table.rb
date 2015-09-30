class AddRecommendationColumnToStocksTable < ActiveRecord::Migration
  def change
    add_column :stocks, :recommendation, :string
  end
end
