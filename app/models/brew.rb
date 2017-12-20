class Brew < ApplicationRecord
  enum status: %w[available exhausted].freeze

  belongs_to :pot, counter_cache: true
  belongs_to :variety, counter_cache: true
  belongs_to :user, counter_cache: true

  after_create_commit { BrewBroadcastJob.perform_later(self) }

  def exhaust
    self.status = :exhausted
    save
  end
end
