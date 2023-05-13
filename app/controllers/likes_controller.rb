class LikesController < ApplicationController
  def create
    @post = Post.find(params[:posts_id])
    @user = ApplicationController.current_user
    @new_like = Like.create(author: @user, post: @post)

    if @new_like.valid?
      flash[:success] = 'Like added successfully'
      respond_to do |format|
        format.html { redirect_to request.referrer, notice: 'Liked' }
      end
    else
      flash[:alert] = 'Error adding a like'
    end
  end
end
