require 'system_helper'

RSpec.describe "Surveys", type: :system do
  let!(:user) { create(:user, email_address: "existing@email.com") }

  before do
    visit new_session_path
    fill_in "Email address", with: user.email_address
    fill_in "Password", with: user.password
    click_on "Login"
  end

  specify "Example surveys can be generated" do
    visit surveys_path

    expect(page).to have_content("No surveys currently exist")

    click_on "Generate Example Survey"

    expect(page).to have_content "Example Survey Generated"
  end

  specify "Surveys can be created, edited, viewed and deleted" do
    visit surveys_path

    click_on "Create"
    click_on "Create Survey"

    expect(page).to have_content "can't be blank"

    fill_in "Name", with: "New Survey"
    click_on "Create Survey"

    expect(page).to have_content "Survey Created!"

    within ".question" do
      fill_in "question[body]", with: ""
      expect(page).to have_content "can't be blank"

      fill_in "question[body]", with: "Rate something from 1-5"
      expect(page).not_to have_content "can't be blank"

      # change question type
      find("label.selection-block", text: "Pick One").click
      expect(page).to have_content "Options"

      click_on "Add Option"
      expect(page).to have_selector(".option", count: 3)

      find(".option:last-child button.remove-option").click
      expect(page).to have_selector(".option", count: 2)

      find(".option-layout .selection-block", text: "Column").click
      expect(page).to have_selector(".options.field.column")
    end

    click_on "Add Question"
    expect(page).to have_selector(".question", count: 2)

    click_on "View Survey"
    expect(page).to have_selector(".question", count: 2)

    accept_confirm do
      click_on "Delete Survey"
    end
    expect(page).to have_content "Survey Deleted"
  end
end
