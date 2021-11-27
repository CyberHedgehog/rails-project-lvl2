# frozen_string_literal: true

require 'test_helper'

class PostLikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @post_one = posts(:one)
    @post_two = posts(:two)
    @user = users(:one)
    sign_in @user
    @like = post_likes(:one)
  end

  test 'should like post' do
    post_like = PostLike.find_by(user_id: @user.id, post_id: @post_two.id)
    assert_not post_like
    post post_likes_path(@post_two)
    post_like = PostLike.find_by(user_id: @user.id, post_id: @post_two.id)
    assert post_like
    assert_redirected_to post_path(@post_two)
  end

  test 'should unlike post' do
    post_like = PostLike.find_by(user_id: @user.id, post_id: @post_one.id)
    assert post_like
    delete post_like_path(post_id: @post_one.id, id: @like.id)
    post_like = PostLike.find_by(user_id: @user.id, post_id: @post_one.id)
    assert_not post_like
    assert_redirected_to post_path(@post_one)
  end

  test 'should not like if unauthorised' do
    sign_out :user
    last_like = @post_one.likes.last
    post post_likes_path(@post_one)
    assert_equal last_like, @post_one.likes.last
    assert_redirected_to new_user_session_path
  end
end
