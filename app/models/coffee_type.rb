class CoffeeType < ApplicationRecord
  validates :name, presence: true

  has_many :brews
end
