class CommentsController < ApplicationController
  def new
    @post = post.find(params[post_id])
    @user = @post.author
    @comment = Comment.new(comment_params)
  end

  def create
    @post = Post.find(params[:post_id])
    @user = @post.author
    @new_comment = Comment.create(post: @post, author: @user, text: comment_params['text'])

    if @new_comment.valid?
      flash[:success] = 'Commented successfully'
      respond_to do |format|
        format.html do
          redirect_to request.referrer, notice: 'Comment added'
        end
      end
    else
      flash[:alert] = 'Error creating the comment'
    end
  end

  private

  def comment_params
    params.require(:new_comment).permit(:text)
  end
end
