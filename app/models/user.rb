class User < ActiveRecord::Base
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
end
