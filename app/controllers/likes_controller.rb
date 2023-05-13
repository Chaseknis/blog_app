class LikesController < ApplicationController
  def create
    user = ApplicationController.current_user
    post = Post.find(params[:posts_id])
    new_like = Like.create(posts_id: post.id, author_id: user.id)
    if new_like.valid?
      flash[:success] = 'Like added successfully'
      respond_to do |format|
        format.html { redirect_to request.referrer, notice: 'Liked' }
      end
    else
      flash[:alert] = 'Error adding a like'
    end
  end
end
