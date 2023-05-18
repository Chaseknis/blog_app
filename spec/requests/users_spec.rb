require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user) do
    User.create(name: 'test',
                photo: 'http://licalhost:3000/anything.jpg',
                bio: 'test',
                posts_counter: 0)
  end

  describe 'User GET/ index ' do
    it 'return user http success' do
      get '/'
      expect(response).to have_http_status(200)
    end

    it 'rendered user template' do
      get '/'
      expect(response).to render_template(:index)
    end

    # it 'user responsed body with correct place holder' do
    #   get '/'
    #   expect(response.body).to include('Users list')
    # end
  end
  describe "User GET /show'" do
    it 'return success for detail user' do
      get "/users/#{user.id}"
      expect(response).to have_http_status(200)
    end
    it 'rendered user detail template' do
      get "/users/#{user.id}"
      expect(response).to render_template(:show)
    end
    # it 'user detail responsed body with correct place holder' do
    #   get "/users/#{user.id}"
    #   expect(response.body).to include('Here are the user details')
    # end
  end
end
