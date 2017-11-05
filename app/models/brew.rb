class Brew < ApplicationRecord
  belongs_to :pot
  belongs_to :variety
  belongs_to :user, counter_cache: true
end
