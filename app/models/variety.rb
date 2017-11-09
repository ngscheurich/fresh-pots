class Variety < ApplicationRecord
  validates :name, presence: true

  has_many :brews

  def self.most_brewed
    Variety.order(brews_count: :desc).first
  end
end
