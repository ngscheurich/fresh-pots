require "test_helper"

class RenderableTest < ActionDispatch::IntegrationTest
  setup do
    class TestController < ApplicationController
      include Renderable
    end
  end
end
