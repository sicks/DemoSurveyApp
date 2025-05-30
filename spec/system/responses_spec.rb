require 'system_helper'

RSpec.describe "Responses", type: :system do
  let!(:user) { create(:user, email_address: "existing@email.com") }
  let!(:survey) { create(:survey_with_questions) }

  before do
    visit new_session_path
    fill_in "Email address", with: user.email_address
    fill_in "Password", with: user.password
    click_on "Login"
  end

  specify "Surveys can be responded to" do
    visit surveys_path

    click_on "New Response"
    expect(page).to have_content("Response Created")
    expect(page).to have_selector(".answer", count: 3)

    within ".answer:nth-child(2)" do
      fill_in "Short Answer", with: " "
      expect(page).to have_content "is required"

      fill_in "Short Answer", with: "Another Short Answer"
      expect(page).not_to have_content "is required"
    end

    within ".answer:nth-child(4)" do
      find(".selection-block:nth-child(2)").click
      expect(page).not_to have_content "at least one"

      find(".selection-block:nth-child(2)").click
      expect(page).to have_content "at least one"

      find(".selection-block:nth-child(2)").click
    end

    accept_confirm do
      click_on "Complete Response"
    end

    expect(page).to have_content "Every question must be answered"

    within ".answer:nth-child(3)" do
      find(".selection-block:nth-child(2)").click
    end

    accept_confirm do
      click_on "Complete Response"
    end

    expect(page).to have_content "Response complete"
  end
end
