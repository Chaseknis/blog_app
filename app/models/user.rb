class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy
  has_many :likes, foreign_key: :author_id, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3, maximum: 50,
                                             too_long: '%<count>s characters is the maximum allowed' }
  validates :posts_counter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }

  def return_recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
