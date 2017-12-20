require "rails_helper"

feature "User updates their profile" do
  scenario "edits their own profile" do
    user = create(:user)
    login_as(user)

    visit edit_user_url(user)
    fill_form(:user, first_name: "John")
    click_on "Save changes"

    expect(page).to have_text "John"
  end

  scenario "edits someone else’s profile" do
    user1 = create(:user, first_name: "Interloper")
    user2 = create(:user)
    login_as(user1)

    visit edit_user_path(user2)

    expect(page).to have_text "Interloper"
  end
end
