require 'rails_helper'
require 'spec_helper'

RSpec.describe "user" do
  before do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]

    login
    visit root_path
    click_link("Log in with Facebook")
  end

  scenario "can view dashboard" do
    visit stocks_path

    expect(page).to have_link("Logout")

    expect(page).to have_content("Welcome to StockWatcher")
    expect(page).to have_content("StockWatcher lets you add your favorite stocks to your watchlist and track them with ease")
    expect(page).to have_content("Copyright © 2015 StockWatcher, Inc.")

    expect(page).to have_button("Add a new stock")
    expect(page).to have_button("View purchased stocks")
  end
end
