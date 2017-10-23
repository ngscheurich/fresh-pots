require "test_helper"

class PotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:basic)
    @pot = pots(:one)
  end

  test "should get index" do
    get pots_url
    assert_response :success
  end

  test "should get new" do
    get new_pot_url
    assert_response :success
  end

  test "should create pot" do
    assert_difference("Pot.count") do
      post pots_url, params: { pot: { name: @pot.name } }
    end

    assert_redirected_to pot_url(Pot.last)
  end

  test "should show pot" do
    get pot_url(@pot)
    assert_response :success
  end

  test "should get edit" do
    get edit_pot_url(@pot)
    assert_response :success
  end

  test "should update pot" do
    patch pot_url(@pot), params: { pot: { name: @pot.name } }
    assert_redirected_to pot_url(@pot)
  end

  test "should destroy pot" do
    assert_difference("Pot.count", -1) do
      delete pot_url(@pot)
    end

    assert_redirected_to pots_url
  end
end
