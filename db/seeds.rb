pots = Pot.create(
  [
    { name: "Break Room" },
    { name: "Kitchen" },
    { name: "Basement" }
  ]
)

coffee_types = CoffeeType.create(
  [
    { name: "Dark Roast" },
    { name: "Coffee & Chicory" }
  ]
)

1.upto(20) do
  Brew.create(pot: pots.sample,
              coffee_type: coffee_types.sample)
end
