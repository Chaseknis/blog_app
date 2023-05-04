class Post < ApplicationRecord
  belongs_to :user, class_name: 'User', counter_cache: true
  has_many :comments, :likes
end
