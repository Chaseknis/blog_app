require 'capybara/rspec'
require 'rails_helper'

RSpec.describe 'User Post Index Page', type: :feature do
  before(:each) do
    @user_one = User.create(name: 'unique_show', photo: 'http://localhost:3000/anything.jpg', bio: 'Anything test')
    @post_one = Post.create(title: 'post one', text: 'post one text', author: @user_one)
    @post_two = Post.create(title: 'post two', text: 'post two text', author: @user_one)
    @post_three = Post.create(title: 'post three', text: 'post three text', author: @user_one)
    @post_four = Post.create(title: 'post four', text: 'post four text', author: @user_one)
    @comment_one = Comment.create(text: 'comment one', author: @user_one, post: @post_one)
    @comment_two = Comment.create(text: 'comment two', author: @user_one, post: @post_one)
    @comment_three = Comment.create(text: 'comment three', author: @user_one, post: @post_one)
    @comment_four = Comment.create(text: 'comment four', author: @user_one, post: @post_one)
    @comment_five = Comment.create(text: 'comment five', author: @user_one, post_id: @post_one)
    @like_one = Like.create(author_id: @user_one, posts_id: @post_one)
  end
  it 'displays the user\'s profile picture' do
    visit user_posts_path(@user_one)
    expect(page).to have_css('.profile_photo')
  end
  it 'displays the user\'s username' do
    visit user_posts_path(@user_one)
    expect(page).to have_content(@user_one.name)
  end
  it 'displays the number of posts the user has written' do
    visit user_posts_path(@user_one)
    expect(page).to have_content(@user_one.posts.count)
  end
  it 'displays a post\'s title' do
    visit user_posts_path(@user_one)
    expect(page).to have_content(@post_one.title)
  end
  it 'displays a portion of the post\'s body' do
    visit user_posts_path(@user_one)
    expect(page).to have_content(@post_one.text[0..20])
  end
  it 'displays the first comments on a post' do
    visit user_posts_path(@user_one.id)
    expect(page).to have_content(@post_one.return_recent_comments.first.text)
  end
  it 'displays the number of comments a post has' do
    visit user_posts_path(@user_one.id)
    expect(page).to have_content(@post_one.comments.count)
  end
  it 'displays the number of likes a post has' do
    visit user_posts_path(@user_one)
    expect(@post_one.likes_counter).to eq(0)
  end
  it 'Check if a section for pagination is visible when there are more posts' do
    visit user_posts_path(@user_one.id)
    expect(page).to have_button('Pagination')
  end
  it 'redirects to a post show page when clicking on a post' do
    visit user_posts_path(@user_one)
    click_link(@post_one.title)
  end
end
