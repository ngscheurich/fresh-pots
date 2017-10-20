require "test_helper"

class PotTest < ActiveSupport::TestCase
  test "should not save pot without a name" do
    pot = Pot.new
    assert_not pot.save
  end
end
