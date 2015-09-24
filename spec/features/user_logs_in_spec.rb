require 'rails_helper'

RSpec.describe "user" do
  before do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end

  scenario "can login with facebook account" do
    login

    visit root_path
    click_link("Log in with Facebook")

    expect(current_path).to eq(stocks_path)
  end

  scenario "can logout" do
    VCR.use_cassette("user_login_test#logout") do
      login
      visit root_path
      click_link("Log in with Facebook")

      click_link("Logout")

      expect(current_path).to eq(root_path)
    end
  end
end
