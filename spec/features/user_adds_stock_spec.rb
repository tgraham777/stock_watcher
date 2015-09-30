require 'rails_helper'
require 'spec_helper'

RSpec.describe "user" do
  before do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]

    login
    visit root_path
    click_link("Log in with Facebook")
  end

  scenario "can add a stock" do
    VCR.use_cassette("user_adds_stock_test#new") do
      visit stocks_path
      click_on "Add a new stock"

      expect(current_path).to eq(new_stock_path)

      fill_in "Ticker symbol", with: "AAPL"
      click_on "Add new stock"

      expect(current_path).to eq(stock_path(Stock.first.id))
      expect(page).to have_content("Apple Inc successfully added!")
      expect(page).to have_content("Apple Inc")
      expect(page).to have_content("Intra-Day Price History")
      expect(page).to have_content("Key Trading Statistics")
      expect(page).to have_content("Trend Analysis Details")
    end
  end
end
