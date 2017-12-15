require "rails_helper"

describe "api/brews/_brew.json.jbuilder" do
  it "renders the brew's pot" do
    pot = create(:pot, name: "Test Pot")
    brew = create(:brew, pot: pot)

    render partial: "api/brews/brew", locals: { brew: brew }

    expect(rendered).to match(/Test Pot/)
  end

  it "renders the brew's variety" do
    variety = create(:variety, name: "Test Variety")
    brew = create(:brew, variety: variety)

    render partial: "api/brews/brew", locals: { brew: brew }

    expect(rendered).to match(/Test Variety/)
  end

  it "renders the brew's user" do
    user = create(:user, email: "user@example.com")
    brew = create(:brew, user: user)

    render partial: "api/brews/brew", locals: { brew: brew }

    expect(rendered).to match(/user@example/)
  end
end
