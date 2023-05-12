class UsersController < ApplicationController
  layout 'users'
  def index
    @users = User.all
    @title = 'Users'
  end

  def show
    @user = User.find(params[:id])
  end
end
