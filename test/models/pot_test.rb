require "test_helper"

class PotTest < ActiveSupport::TestCase
  test "should not save pot without a name" do
    pot = Pot.new
    assert_not pot.save
  end

  test "#recent_brews returns the correct data" do
    pot = Pot.create(name: "Pot")
    1.upto(10) { Brew.create(pot: pot) }
    brew = Brew.create(pot: pot)
    assert_equal(pot.recent_brews(1), [brew])
  end
end
