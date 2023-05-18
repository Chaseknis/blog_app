require 'capybara/rspec'
require 'rails_helper'

RSpec.describe 'User Show Page', type: :feature do
  before(:each) do
    @user_one = User.create(name: 'unique show', photo: 'http://localhost:3000/anything.jpg', bio: 'Anything test')
    @post_one = Post.create(title: 'post one', text: 'post one text', author: @user_one)
    @post_two = Post.create(title: 'post two', text: 'post two text', author: @user_one)
    @post_three = Post.create(title: 'post three', text: 'post three text', author: @user_one)
    @post_four = Post.create(title: 'post four', text: 'post four text', author: @user_one)
  end
  it 'displays the user\'s profile picture' do
    visit user_path(@user_one.id)
    expect(@user_one.photo).to match(%r{^http?://.*\.(jpe?g|gif|png)$})
  end
  it 'displays the user\'s username' do
    visit user_path(@user_one.id)
    expect(page).to have_content(@user_one.name)
  end
  it 'displays the number of posts the user has written' do
    visit user_path(@user_one.id)
    expect(page).to have_content(@user_one.posts.count)
  end
  it 'displays the user\'s bio' do
    visit user_path(@user_one.id)
    expect(page).to have_content(@user_one.bio)
  end
  it 'displays the user\'s first 3 posts' do
    visit user_path(@user_one.id)
    expect(page).to have_css('.post_tile', count: 3)
  end
  it 'redirects to a post show page when clicking on a user\'s post' do
    visit user_path(@user_one.id)
    expect(page).to have_content(@user_one.return_recent_posts.first.title)
    expect(page).to have_content(@user_one.return_recent_posts.second.title)
    expect(page).to have_content(@user_one.return_recent_posts.third.title)
  end
  it 'redirects to the user\'s post index page when clicking to view all posts' do
    visit user_path(@user_one.id)
    click_link('See all posts')
    expect(page).to have_current_path(user_posts_path(@user_one))
  end
end