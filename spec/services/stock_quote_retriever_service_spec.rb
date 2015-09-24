require 'rails_helper'

RSpec.describe StockQuoteRetrieverService, type: :model do
  attr_reader :service

  before(:each) do
    @service = StockQuoteRetrieverService.new
  end

  it "returns the name of a stock" do
    VCR.use_cassette("get_stock_quote") do
      ticker = "AAPL"
      stock_data = service.get_quote(ticker)
      expect(stock_data[:Name]).to eq("Apple Inc")
    end
  end

  it "returns the symbol of a stock" do
    VCR.use_cassette("get_stock_quote") do
      ticker = "AAPL"
      stock_data = service.get_quote(ticker)
      expect(stock_data[:Symbol]).to eq("AAPL")
    end
  end

  it "returns the status of the query" do
    VCR.use_cassette("get_stock_quote") do
      ticker = "AAPL"
      stock_data = service.get_quote(ticker)
      expect(stock_data[:Status]).to eq("SUCCESS")
    end
  end

  it "returns the name of a different stock" do
    VCR.use_cassette("get_another_stock_quote") do
      ticker = "UTX"
      stock_data = service.get_quote(ticker)
      expect(stock_data[:Name]).to eq("United Technologies Corp")
    end
  end

  it "returns the symbol of a different stock" do
    VCR.use_cassette("get_another_stock_quote") do
      ticker = "UTX"
      stock_data = service.get_quote(ticker)
      expect(stock_data[:Symbol]).to eq("UTX")
    end
  end

  it "returns the name of a different stock" do
    VCR.use_cassette("get_another_stock_quote") do
      ticker = "UTX"
      stock_data = service.get_quote(ticker)
      expect(stock_data[:Status]).to eq("SUCCESS")
    end
  end
end
