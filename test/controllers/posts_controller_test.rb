# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @post = posts(:one)
    @user = users(:one)
    @post_category = post_categories(:one)
    @title = Faker::Lorem.sentence
    @body = Faker::Lorem.sentences.join(' ')
    sign_in @user
  end

  test 'should get index' do
    get posts_path
    assert_response :success
  end

  test 'should get new' do
    get new_post_path
    assert_response :success
  end

  test 'should get edit' do
    get edit_post_path(@post)
    assert_response :success
  end

  test 'should show' do
    sign_out :user
    get post_path(@post)
    assert_response :success
  end

  test 'should not create post if unauthorized' do
    sign_out :user
    post posts_path, params: { post: {
      title: @title,
      body: @body,
      post_category_id: @post_category.id
    } }
    new_post = Post.find_by(title: @title)
    assert_not new_post
    assert_redirected_to new_user_session_path
  end

  test 'should create post' do
    post posts_path, params: { post: {
      title: @title,
      body: @body,
      post_category_id: @post_category.id
    } }
    new_post = Post.find_by(title: @title)
    assert new_post
    assert_redirected_to post_path(Post.last)
  end

  test 'should not update post if unauthorized' do
    sign_out :user
    old_body_value = @post.body
    put post_path(@post), params: { post: {
      title: @post.title,
      body: 'New body',
      post_category_id: @post.post_category_id
    } }
    assert Post.find(@post.id).body, old_body_value
    assert_redirected_to new_user_session_path
  end

  test 'should update post' do
    put post_path(@post), params: { post: {
      title: @post.title,
      body: @body,
      post_category_id: @post.post_category_id
    } }
    assert_redirected_to post_path(@post)
    assert Post.find(@post.id).body, @body
  end
end
