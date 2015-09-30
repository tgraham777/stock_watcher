require 'rails_helper'
require 'spec_helper'

RSpec.describe "user" do
  before do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]

    login
    visit root_path
    click_link("Log in with Facebook")
  end

  scenario "deletes stock from watchlist" do
    VCR.use_cassette("user_deletes_stock#destroy") do
      visit stocks_path
      click_on "Add a new stock"
      fill_in "Ticker symbol", with: "AAPL"
      click_on "Add new stock"
      expect(current_path).to eq(stock_path(Stock.first.id))

      click_on "Remove from watchlist"

      expect(current_path).to eq(stocks_path)
      expect(page).to have_content("Apple Inc successfully removed!")
      expect(page).to_not have_content("AAPL")
    end
  end
end
