class Pot < ApplicationRecord
  validates :name, presence: true
  validates_associated :brews

  has_many :brews

  def recent_brews(amt = 5)
    brews.order(created_at: :desc).first(amt)
  end
end
