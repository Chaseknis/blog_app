require 'capybara/rspec'
require 'rails_helper' # Assuming you're using Rails and have a `rails_helper.rb` file

RSpec.describe 'User Index Page', type: :feature do
  before(:each) do
    @user_one = User.create(name: 'unique', photo: 'http://localhost:3000/anything.jpg', bio: 'Anything test')
    @post = Post.create(title: 'Anything', text: 'Anything test', author: @user_one)
  end

  it 'displays the username of all other users' do
    visit users_path
    expect(page).to have_content(@user_one.name)
  end

  it 'displays the profile picture for each user' do
    visit users_path
    expect(@user_one.photo).to match(%r{^http?://.*\.(jpe?g|gif|png)$})
  end

  it 'displays the number of posts each user has written' do
    visit users_path
    expect(page).to have_content(@user_one.posts.count)
  end

  it 'redirects to the user show page when clicking on a user' do
    visit users_path
    click_link(@user_one.name)
    expect(page).to have_current_path(user_path(@user_one.id))
  end
end
