require "test_helper"

class BrewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @brew = brews(:one)
  end

  test "should get index" do
    get brews_url
    assert_response :success
  end

  test "should get new" do
    get new_brew_url
    assert_response :success
  end

  test "should create brew" do
    assert_difference("Brew.count") do
      post brews_url, params: { brew: { pot_id: @brew.pot_id } }
    end

    assert_redirected_to brew_url(Brew.last)
  end

  test "should show brew" do
    get brew_url(@brew)
    assert_response :success
  end

  test "should get edit" do
    get edit_brew_url(@brew)
    assert_response :success
  end

  test "should update brew" do
    patch brew_url(@brew), params: { brew: { pot_id: @brew.pot_id } }
    assert_redirected_to brew_url(@brew)
  end

  test "should destroy brew" do
    assert_difference("Brew.count", -1) do
      delete brew_url(@brew)
    end

    assert_redirected_to brews_url
  end
end
