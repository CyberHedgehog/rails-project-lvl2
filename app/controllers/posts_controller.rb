class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.order(created_at: :desc)
  end

  def new
    if user_signed_in?
      @post = Post.new
    else
      redirect_to posts_path
    end
  end

  def show; end

  def create
    unless user_signed_in?
      redirect_to root_path
      return
    end
    @post = Post.new(user_id: current_user.id, **post_params)
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit
    redirect_to posts_path unless user_signed_in?
  end

  def update
    if @post.user != current_user
      render :edit
      return
    end
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.user != current_user
      redirect_to posts_path
      return
    end
    @post.destroy
    redirect_to posts_url
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :post_category_id)
  end
end
