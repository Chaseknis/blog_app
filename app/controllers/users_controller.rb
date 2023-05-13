class UsersController < ApplicationController
  layout 'users'
  def index
    @users = User.all.order(updated_at: :asc)
    @current_user = ApplicationController.current_user
  end

  def show
    @user = User.find(params[:id])
  end
end
