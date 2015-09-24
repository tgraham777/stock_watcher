class StockQuoteRetrieverService
  attr_reader :connection

  def initialize
    @connection = Hurley::Client.new("http://dev.markitondemand.com/Api/v2/")
  end

  def get_quote(symbol)
    response = connection.get("Quote/json", { symbol: symbol })
    response_body = parse(response.body)
  end

  private

  def parse(response)
    JSON.parse(response, symbolize_names: true)
  end
end
