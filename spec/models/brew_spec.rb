require "rails_helper"

describe Brew do
  it { should belong_to(:pot) }
  it { should belong_to(:variety) }
end
