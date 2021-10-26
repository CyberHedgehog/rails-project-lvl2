class Posts::LikesController < ApplicationController
  def create
    PostLike.create(post_id: params[:post_id], user_id: current_user[:id]) if user_signed_in?
    redirect_to post_path(params[:post_id])
  end

  def destroy
    if user_signed_in?
      like = PostLike.where(user_id: current_user.id, post_id: params[:post_id]).first
      like.destroy
    end
    redirect_to post_path(params[:post_id])
  end
end
