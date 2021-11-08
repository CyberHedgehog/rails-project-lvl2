class Posts::CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @comment = PostComment.new(comment_params.merge(user_id: current_user.id, post_id: params[:post_id]))
    if @comment.save
      redirect_to post_path(params[:post_id])
    else
      render :new
      # TODO: Выяснить, что рендерить, если комент не прошел валидацию
    end
  end

  private

  def comment_params
    params.require(:post_comment).permit(:content, :parent_id)
  end
end
