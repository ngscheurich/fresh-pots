require "rails_helper"

describe Variety do
  it { should validate_presence_of(:name) }
  it { should have_many(:brews) }
end
