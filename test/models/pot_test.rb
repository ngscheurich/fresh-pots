require "test_helper"

class PotTest < ActiveSupport::TestCase
  test "should not save pot without a name" do
    pot = Pot.new
    assert_not pot.save
  end

  test "#recent_brews returns the correct data" do
    pot = Pot.create(name: "Pot")
    ctype = coffee_types(:one)
    1.upto(10) { Brew.create(pot: pot, coffee_type: ctype) }
    brew = Brew.create(pot: pot, coffee_type: ctype)
    assert_equal(pot.recent_brews(1), [brew])
  end
end
