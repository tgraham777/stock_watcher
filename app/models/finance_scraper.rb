require 'nokogiri'
require 'open-uri'

class FinanceScraper
  def self.find_spy_price
    page = Nokogiri::HTML(open("http://www.investing.com/indices/us-spx-500-components"))
    spy_price = page.css('span#last_last').text
    spy_price.to_s
  end

  def self.find_spy_daily_percent_change
    page = Nokogiri::HTML(open("http://www.investing.com/indices/us-spx-500-components"))
    daily_change_with_symbol = page.css('span.arial_20.greenFont.pid-166-pcp.parentheses').text
    daily_change = daily_change_with_symbol.delete('+').delete('-').delete('%')
  end
end
