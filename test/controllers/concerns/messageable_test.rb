require "test_helper"

class MessageableTest < ActionDispatch::IntegrationTest
  setup do
    class TestController < ApplicationController
      include Messageable
    end
  end

  test "generates created message correctly" do
    expected = "Test was successfully created."
    assert_equal(TestController.new.created_message, expected)
  end

  test "generates updated message correctly" do
    expected = "Test was successfully updated."
    assert_equal(TestController.new.updated_message, expected)
  end

  test "generates destroyed message correctly" do
    expected = "Test was successfully destroyed."
    assert_equal(TestController.new.destroyed_message, expected)
  end
end
