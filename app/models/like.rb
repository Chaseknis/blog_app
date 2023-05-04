class Like < ApplicationRecord
  belongs_to :users
  belongs_to :posts, counter_cache: true
end
