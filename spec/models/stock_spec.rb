require 'rails_helper'
require 'spec_helper'

RSpec.describe Stock, type: :model do
  context "finds long-term trend" do
    it "returns overvalued" do
      ytd_stock_change = 11.75
      ytd_spy_change = -8.16

      expect(Stock.find_lt_trend(ytd_stock_change, ytd_spy_change)).to eq("Overvalued")
    end

    it "returns somewhat overvalued" do
      ytd_stock_change = 1.75
      ytd_spy_change = -8.16

      expect(Stock.find_lt_trend(ytd_stock_change, ytd_spy_change)).to eq("Somewhat overvalued")
    end

    it "returns fairly valued" do
      ytd_stock_change = 0.75
      ytd_spy_change = -8.16

      expect(Stock.find_lt_trend(ytd_stock_change, ytd_spy_change)).to eq("Fairly valued")
    end

    it "returns somewhat undervalued" do
      ytd_stock_change = -20.75
      ytd_spy_change = -8.16

      expect(Stock.find_lt_trend(ytd_stock_change, ytd_spy_change)).to eq("Somewhat undervalued")
    end

    it "returns undervalued" do
      ytd_stock_change = -30.75
      ytd_spy_change = -8.16

      expect(Stock.find_lt_trend(ytd_stock_change, ytd_spy_change)).to eq("Undervalued")
    end
  end

  context "finds short-term trend" do
    it "returns hot" do
      stock_change = 1.38
      spy_change = -1.12

      expect(Stock.find_st_trend(stock_change, spy_change)).to eq("Hot")
    end

    it "returns outperforming" do
      stock_change = 0.38
      spy_change = -1.12

      expect(Stock.find_st_trend(stock_change, spy_change)).to eq("Outperforming")
    end

    it "returns neutral" do
      stock_change = 0.38
      spy_change = -0.27

      expect(Stock.find_st_trend(stock_change, spy_change)).to eq("Neutral")
    end

    it "returns underperforming" do
      stock_change = -1.38
      spy_change = -0.27

      expect(Stock.find_st_trend(stock_change, spy_change)).to eq("Underperforming")
    end

    it "returns cold" do
      stock_change = -2.38
      spy_change = -0.27

      expect(Stock.find_st_trend(stock_change, spy_change)).to eq("Cold")
    end
  end

  context "finds overall trend" do
    it "returns wait to purchase when overvalued and hot" do
      lt_trend = "Overvalued"
      st_trend = "Hot"

      expect(Stock.overall_trend(lt_trend, st_trend)).to eq("Wait to purchase or sell")
    end

    it "returns potential selling opportunity" do
      lt_trend = "Overvalued"
      st_trend = "Cold"

      expect(Stock.overall_trend(lt_trend, st_trend)).to eq("Potential selling opportunity")
    end

    it "returns potential breakout to the upside" do
      lt_trend = "Fairly valued"
      st_trend = "Hot"

      expect(Stock.overall_trend(lt_trend, st_trend)).to eq("Potential breakout to the upside in progress")
    end

    it "returns wait to purchase when fairly valued and neutral" do
      lt_trend = "Fairly valued"
      st_trend = "Neutral"

      expect(Stock.overall_trend(lt_trend, st_trend)).to eq("Wait to purchase or sell")
    end

    it "returns potential breakout to the downside" do
      lt_trend = "Fairly valued"
      st_trend = "Cold"

      expect(Stock.overall_trend(lt_trend, st_trend)).to eq("Potential breakout to the downside in progress")
    end

    it "returns potential rebound in progress" do
      lt_trend = "Undervalued"
      st_trend = "Hot"

      expect(Stock.overall_trend(lt_trend, st_trend)).to eq("Potential rebound in progress, consider buying")
    end

    it "returns wait to sell when undervalued and cold" do
      lt_trend = "Undervalued"
      st_trend = "Cold"

      expect(Stock.overall_trend(lt_trend, st_trend)).to eq("Wait to purchase or sell")
    end
  end
end
