class PostPolicy < ApplicationPolicy
  attr_reader :user, :post

  def initialize(user, post)
    super
    @user = user
    @post = post
  end

  def index?
    true
  end

  def create?
    @user.present?
  end

  def update?
    return true if @user.present? && @user == @post.creator
  end

  def destroy?
    return true if @user.present? && @user == @post.creator
  end
end
