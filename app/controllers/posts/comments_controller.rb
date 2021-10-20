class Posts::CommentsController < ApplicationController
  def create
    unless user_signed_in?
      redirect_to root_path
      return
    end
    @comment = PostComment.new(comment_params.merge(user_id: current_user[:id], post_id: params[:post_id]))
    if @comment.save
      redirect_to post_path(params[:post_id])
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:post_comment).permit(:content, :parent_id)
  end
end
