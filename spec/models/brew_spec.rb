require "rails_helper"

describe Brew do
  it { should belong_to(:pot) }
  it { should belong_to(:variety) }

  describe "#exhaust" do
    it "should change the status of the brew to 'exhausted'" do
      brew = create(:brew)
      brew.exhaust
      expect(brew.status).to eq("exhausted")
    end
  end
end
