class PostsController < ApplicationController
  layout 'posts'

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def new
    @post = Post.new
    @current_user = ApplicationController.current_user
  end

  def create
    current_user = ApplicationController.current_user
    @new_post =
      Post.new(
        author: current_user,
        title: post_params['title'],
        text: post_params['text'],
        likes_counter: 0,
        comments_counter: 0
      )

    if @new_post.save
      flash[:success] = 'posted successfully'
      redirect_to user_post_path(current_user.id, @new_post.id)
    else
      flash[:alert] = 'error creating post'
    end
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
  end

  private

  def post_params
    params.require(:new_post).permit(:title, :text)
  end
end
