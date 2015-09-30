require 'rails_helper'
require 'spec_helper'

RSpec.describe "user" do
  before do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]

    login
    visit root_path
    click_link("Log in with Facebook")
  end

  scenario "updates stock data" do
    VCR.use_cassette("user_updates_stock_data#edit") do
      visit stocks_path
      click_on "Add a new stock"
      fill_in "Ticker symbol", with: "AAPL"
      click_on "Add new stock"
      click_on "Update data"

      expect(current_path).to eq(stock_path(Stock.first.id))
      expect(page).to have_content("Apple Inc successfully updated!")
    end
  end
end
