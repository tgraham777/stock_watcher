require 'rails_helper'

RSpec.describe "user" do
  before do
    visit root_path
  end

  scenario "can visit welcome page" do
    expect(page.status_code).to eq(200)
    expect(page).to have_content("Welcome to StockWatcher")
    expect(page).to have_link("Log in with Yahoo!")
  end

  scenario "can visit Yahoo! new account page" do
    expect(page).to have_link("create one.", href: "http://edit.yahoo.com/registration")
  end
end
