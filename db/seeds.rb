pots = Pot.create(
  [
    { name: "First Floor Kitchen" },
    { name: "Second Floor Kitchen" },
    { name: "Third Floor Kitchen" }
  ]
)

varieties = Variety.create(
  [
    { name: "Dark Roast" },
    { name: "Café Special" },
    { name: "Other" }
  ]
)

User.create({ email: "user@example.com", password: "password" })
User.first.confirmed_at(Time.zone.now).save

1.upto(5) do
  Brew.create(
    pot: pots.sample,
    variety: varieties.sample,
    user: User.first
  )
end
