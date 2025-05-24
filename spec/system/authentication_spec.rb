require 'system_helper'

RSpec.describe "Authentication", type: :system do
  let!(:user) { create(:user, email_address: "existing@email.com") }

  specify "new users can be created and signed in at the same time" do
    visit root_path

    expect(page).to have_current_path "/session/new"

    fill_in("Email address", with: "nonexistent@email.com")
    fill_in("Password", with: "password")
    fill_in("Password confirmation", with: "password")
    click_button "Login"

    expect(page).to have_current_path "/"
  end

  specify "existing users can log in and out" do
    visit root_path

    expect(page).to have_current_path "/session/new"

    fill_in("Email address", with: "existing@email.com")
    fill_in("Password", with: "password")
    click_button "Login"

    expect(page).to have_current_path "/"

    click_on "Log out"

    expect(page).to have_current_path "/session/new"
  end
end
