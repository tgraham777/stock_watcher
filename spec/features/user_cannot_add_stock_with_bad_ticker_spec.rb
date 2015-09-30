require 'rails_helper'
require 'spec_helper'

RSpec.describe "user" do
  before do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]

    login
    visit root_path
    click_link("Log in with Facebook")
  end

  scenario "cannot add a stock with improper ticker" do
    VCR.use_cassette("user_cannot_add_stock_test#new") do
      visit stocks_path
      click_on "Add a new stock"

      fill_in "Ticker symbol", with: "AAPLE"
      click_on "Add new stock"

      expect(page).to have_content("No symbol matches found for AAPLE.")
    end
  end
end
