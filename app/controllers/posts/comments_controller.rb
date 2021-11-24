# frozen_string_literal: true

module Posts
  class CommentsController < ApplicationController
    before_action :authenticate_user!
    def create
      @post = Post.find(params[:post_id])
      @comment = @post.comments.new(user_id: current_user.id, **comment_params)
      if @comment.save
        redirect_to post_path(@post)
      else
        redirect_to post_path(@post), alert: @comment.errors.full_messages.first
      end
    end

    private

    def comment_params
      params.require(:post_comment).permit(:content, :parent_id)
    end
  end
end
