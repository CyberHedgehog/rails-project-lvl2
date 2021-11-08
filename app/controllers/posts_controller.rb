class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :set_categories, only: %i[new edit create]
  before_action :authenticate_user!, except: %i[index show]

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

  def show
    @comment = PostComment.new
    @current_user_like = @post.likes.find_by(user: current_user)
  end

  def create
    @post = Post.new(creator: current_user, **post_params)
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
    if @post.creator != current_user
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
    if @post.creator != current_user
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

  def set_categories
    @categories = PostCategory.all
  end

  def post_params
    params.require(:post).permit(:title, :body, :post_category_id)
  end
end
