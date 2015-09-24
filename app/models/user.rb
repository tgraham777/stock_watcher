class User < ActiveRecord::Base
  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  def self.find_or_create_from_auth(auth)
    user = User.find_or_create_by(provider: auth.provider, uid: auth.uid)

    user.name = auth.info.name
    user.image_url = auth.info.image
    user.token = auth.credentials.token

    user.save
    user
  end

  def create_stock_array
    ids = self.stocks.map do |stock|
      stock.id
    end

    service = StockQuoteRetrieverService.new

    stock_data = self.stocks.map do |stock|
      service.get_quote(stock.ticker)
    end

    ids.zip(stock_data)
  end
end
