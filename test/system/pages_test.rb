require "application_system_test_case"

class PagesTest < ApplicationSystemTestCase
  test "visiting the home page" do
    visit home_url

    assert_selector "h1", text: "Fresh Pots"
  end
end
