require 'capybara/rspec'
require 'rails_helper'

RSpec.describe 'Post Show Page', type: :feature do
    before(:each) do
        @user_one = User.create(name: 'unique_show', photo: 'http://localhost:3000/anything.jpg', bio: 'Anything test')
        @post_one = Post.create(title: 'post one', text: 'post one text', author: @user_one)
        @post_two = Post.create(title: 'post two', text: 'post two text', author: @user_one)
        @post_three = Post.create(title: 'post three', text: 'post three text', author: @user_one)
        @post_four = Post.create(title: 'post four', text: 'post four text', author: @user_one)
        @comment_one = Comment.create(text: 'comment one', author: @user_one, post: @post_one)
        @comment_two = Comment.create(text: 'comment two', author: @user_one, post: @post_one)
        @comment_three = Comment.create(text: 'comment three', author: @user_one, post: @post_one)
        @comment_four = Comment.create(text: 'comment four', author: @user_one, post_id: @post_one)
        @comment_five = Comment.create(text: 'comment five', author: @user_one, post_id: @post_one)
        @like_one = Like.create(author: @user_one, posts_id: @post_one)
    end

  it 'displays the post title' do
    visit user_post_path(@user_one.id, @post_one.id)
    expect(page).to have_content(@post_one.title)
  end

  it 'displays the author of the post' do
    visit user_post_path(@user_one.id, @post_one.id)
    expect(page).to have_content(@post_one.author.name)
  end

  it 'displays the number of comments the post has' do
    visit user_post_path(@user_one.id, @post_one.id)
    expect(page).to have_content(@post_one.comments.count)
  end

  it 'displays the number of likes the post has' do
    @post.likes.create(author: @user)
    visit post_path(@post)
    expect(page).to have_content('Likes:', count: 1)
    expect(page).to have_content(@post.likes.count)
  end

  it 'displays the post body' do
    visit user_post_path(@user_one.id, @post_one.id)
    expect(page).to have_content(@post_one.text)
  end

  it 'displays the username of each commentor' do
    visit post_path(@post)
    @post.comments.each do |comment|
      expect(page).to have_content(comment.author.name)
    end
  end

  it 'displays the comment left by each commentor' do
    visit post_path(@post)
    @post.comments.each do |comment|
      expect(page).to have_content(comment.text)
    end
  end
end
