class Brew < ApplicationRecord
  validates :pot, presence: true

  belongs_to :pot
end
