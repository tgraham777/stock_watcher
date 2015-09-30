class UserStock < ActiveRecord::Base
  belongs_to :user
  belongs_to :stock

  def total_value(quantity, price)
    quantity.to_i * price.to_f
  end

  def find_change_ytd
    original_price = 2058.2
    current_price = FinanceScraper.find_spy_price.delete(',').to_f

    ((current_price - original_price) / original_price) * 100
  end

  def find_stock_return(purchase_price, current_price)
    original_price = purchase_price.delete(',').to_f
    present_price = current_price.delete(',').to_f
    ((present_price - original_price) / original_price) * 100
  end

  def find_spy_return(purchase_price)
    current_price = FinanceScraper.find_spy_price.delete(',').to_f
    original_price = purchase_price.delete(',').to_f

    ((current_price - original_price) / original_price) * 100
  end
end
