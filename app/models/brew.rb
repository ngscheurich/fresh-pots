class Brew < ApplicationRecord
  belongs_to :pot, counter_cache: true
  belongs_to :variety, counter_cache: true
  belongs_to :user, counter_cache: true
end
