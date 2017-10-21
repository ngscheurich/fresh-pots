class Brew < ApplicationRecord
  belongs_to :pot
  belongs_to :coffee_type
end
