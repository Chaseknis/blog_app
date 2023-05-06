class Comment < ApplicationRecord
  belongs_to :author, foreign_key: :author_id, class_name: 'User'
  belongs_to :post, class_name: 'Post', counter_cache: :comments_counter

  after_save :update_comments_counter

  validates :text, presence: true,
                   length: { minimum: 3, maximum: 250, too_long: '%<count>s is the maximum characters allowed',
                             too_short: '%<count>s is the minimum characters allowed' }

  def update_comments_counter
    post.increment!(:comments_counter)
  end
end
