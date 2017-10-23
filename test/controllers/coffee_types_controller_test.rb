require "test_helper"

class CoffeeTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:basic)
    @coffee_type = coffee_types(:one)
    @valid_params = { coffee_type: { name: "Coffee & Chicory" } }
  end

  test "should get index" do
    get coffee_types_url
    assert_response :success
  end

  test "should get new" do
    get new_coffee_type_url
    assert_response :success
  end

  test "should create coffee_type" do
    assert_difference("CoffeeType.count") do
      post coffee_types_url, params: @valid_params
    end

    assert_redirected_to coffee_type_url(CoffeeType.last)
  end

  test "should show coffee_type" do
    get coffee_type_url(@coffee_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_coffee_type_url(@coffee_type)
    assert_response :success
  end

  test "should update coffee_type" do
    patch coffee_type_url(@coffee_type), params: @valid_params
    assert_redirected_to coffee_type_url(@coffee_type)
  end

  test "should destroy coffee_type" do
    assert_difference("CoffeeType.count", -1) do
      delete coffee_type_url(@coffee_type)
    end

    assert_redirected_to coffee_types_url
  end
end
