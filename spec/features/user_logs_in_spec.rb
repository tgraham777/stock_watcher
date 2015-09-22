require 'rails_helper'

RSpec.describe "user" do
  before do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
  end

  xscenario "can login with github account" do
    login
    visit root_path
    click_link("Login with Github")

    expect(current_path).to eq(dashboard_path)
  end

  xscenario "can logout" do
    VCR.use_cassette("user_login_test#logout") do
      login
      visit root_path
      click_link("Login with Github")

      click_link("Logout")

      expect(current_path).to eq(root_path)
    end
  end
end
