class UserStock < ActiveRecord::Base
  belongs_to :user
  belongs_to :stock

  def total_value(quantity, price)
    quantity.to_i * price.to_f
  end
end
