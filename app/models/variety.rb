class Variety < ApplicationRecord
  validates :name, presence: true

  has_many :brews
end
