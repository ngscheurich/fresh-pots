class Pot < ApplicationRecord
  validates :name, presence: true
  validates_associated :brews

  has_many :brews

  def self.most_used
    Pot.order(brews_count: :desc).first
  end

  def recent_brews(limit = 5)
    brews.order(created_at: :desc).first(limit)
  end
end
