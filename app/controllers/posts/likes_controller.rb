class Posts::LikesController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]
  def create
    PostLike.create(post_id: params[:post_id], user_id: current_user.id)
    redirect_to post_path(params[:post_id])
  end

  def destroy
    like = PostLike.where(user_id: current_user.id, post_id: params[:post_id]).first
    like.destroy
    redirect_to post_path(params[:post_id])
  end
end
