class Brew < ApplicationRecord
  belongs_to :pot
  belongs_to :variety
end
