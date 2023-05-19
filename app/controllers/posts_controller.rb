class PostsController < ApplicationController
  layout 'posts'

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
  end

  def new
    @post = Post.new
    @current_user = params[:user_id]
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0
    if @post.save
      flash[:notice] = 'Post was successfully created.'
      redirect_to user_post_path(current_user, @post)
    else
      flash.now[:alert] = 'Post was not created.'
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
