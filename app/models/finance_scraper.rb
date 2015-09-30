require 'nokogiri'
require 'open-uri'

class FinanceScraper
  def self.find_spy_price
    page = Nokogiri::HTML(open("http://www.investing.com/indices/us-spx-500-components"))
    spy_price = page.css('span#last_last').text
    spy_price.to_s
  end
end

# <span class="arial_26 inlineblock pid-166-last" id="last_last" dir="ltr">1,884.08</span>
