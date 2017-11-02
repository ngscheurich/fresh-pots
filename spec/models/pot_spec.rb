require "rails_helper"

describe Pot do
  it { should validate_presence_of(:name) }
  it { should have_many(:brews) }

  describe "#recent_brews" do
    it "returns a list of the pot's recent brews" do
      pot = create(:pot)
      brew = create(:brew, pot: pot)
      expect(pot.recent_brews(1)).to eq([brew])
    end
  end
end
