require "rails_helper"

describe Messageable do
  before(:all) do
    class MessageablesController < ApplicationController
      include Messageable
    end
  end

  it "generates created message correctly" do
    expected = "Messageable was successfully created."
    expect(MessageablesController.new.created_message).to eq(expected)
  end

  it "generates updated message correctly" do
    expected = "Messageable was successfully updated."
    expect(MessageablesController.new.updated_message).to eq(expected)
  end

  it "generates destroyed message correctly" do
    expected = "Messageable was successfully destroyed."
    expect(MessageablesController.new.destroyed_message).to eq(expected)
  end
end
