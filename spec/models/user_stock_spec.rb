require 'rails_helper'
require 'spec_helper'

RSpec.describe UserStock, type: :model do
  context "finds total value" do
    it "returns total" do
      quantity = 12
      price = 10

      expect(UserStock.new.total_value(quantity, price)).to eq(120)
    end
  end

  context "finds s&p 500 change year-to-date" do
    it "calculates return value" do
      VCR.use_cassette("calculate_spy_return#show") do
        expect(UserStock.find_change_ytd.class).to eq(Float)
      end
    end
  end

  context "finds stock change year-to-date" do
    it "calculates return value" do
      original_price = '100'
      present_price = '110'

      expect(UserStock.new.find_stock_return(original_price, present_price)).to eq(10)
    end
  end

  context "finds S&P 500 return" do
    it "calculates return value" do
      purchase_price = '100'

      VCR.use_cassette("calculate_spy_percent_return#show") do
        expect(UserStock.new.find_spy_return(purchase_price).class).to eq(Float)
      end
    end
  end

  context "finds profit/loss" do
    it "calculates value" do
      original_price = '100'
      present_price = '110'
      quantity = '10'

      expect(UserStock.new.find_profit_loss(original_price, present_price, quantity)).to eq(100)
    end
  end
end
