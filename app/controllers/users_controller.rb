class UsersController < ApplicationController
  before_action :authenticate_user!
  layout 'users'
  def index
    @users = User.all
  end

  def show
    if params[:id] == 'sign_out'
      sign_out_and_redirect
    else
      find_user
    end
  end

  def sign_out_and_redirect
    sign_out current_user
    redirect_to root_path
  end

  def find_user
    @user = User.find(params[:id])
    @posts = @user.return_recent_posts
  end
end
