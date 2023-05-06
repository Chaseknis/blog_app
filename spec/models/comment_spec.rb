require 'rails_helper'

RSpec.describe Comment, type: :model do
  user = User.new(name: 'Anything', photo: 'http://licalhost:3000/anything.jpg', bio: 'This is a bio test',
                  posts_counter: 0)
  post = Post.new(title: 'Anything', text: 'This is a bio test', author: user, comments_counter: 0, likes_counter: 0)

  subject(:comment) do
    Comment.new(text: 'Test comments', author: user, post: post)
  end
end
