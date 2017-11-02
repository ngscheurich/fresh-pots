require "rails_helper"

feature "User visits home page" do
  scenario "sees page title" do
    visit root_path

    expect(page).to have_css "h1", text: "Fresh Pots"
  end
end
