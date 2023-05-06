require 'rails_helper'

RSpec.describe Post, type: :model do
  user = User.new(name: 'Anything', photo: 'http://licalhost:3000/anything.jpg', bio: 'This is a bio test',
                  posts_counter: 0)
  subject do
    described_class.new(
      title: 'Anything',
      text: 'This is a bio test',
      author: user,
      comments_counter: 0,
      likes_counter: 0
    )
  end
  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
  it 'is invalid without a title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end
  it 'is invalid with a length for title more than 250' do
    title = ''
    title += 'a' while title.length < 251
    subject.title = title
    expect(subject).to_not be_valid
  end
  it 'comment counter is invalid with a negative number' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end
  it 'comment counter is invalid with a string' do
    subject.comments_counter = 'string'
    expect(subject).to_not be_valid
  end
  it 'like counter is invalid with a negative number' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end
  it 'like counter is invalid with a string' do
    subject.likes_counter = 'string'
    expect(subject).to_not be_valid
  end
  describe '#five_recent_comments, counter private methods' do
    let(:user1) { User.new(name: 'Dylan Foster') }
    let(:post) { Post.new(author: user1, text: '1', title: '1') }
    let!(:comment1) { Comment.new(author: user1, post: post, text: '1') }
    let!(:comment2) { Comment.new(author: user1, post: post, text: '2') }
    let!(:comment3) { Comment.new(author: user1, post: post, text: '3') }
    let!(:comment4) { Comment.new(author: user1, post: post, text: '4') }
    let!(:comment5) { Comment.new(author: user1, post: post, text: '5') }
    let!(:comment6) { Comment.new(author: user1, post: post, text: '6') }
    before do
      post.comments = [comment1, comment2, comment3, comment4, comment5]
      post.save
    end
  end
end
