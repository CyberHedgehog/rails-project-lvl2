require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @post = posts(:one)
    sign_in users(:one)
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

  test 'should redirect if unauthorized' do
    sign_out :user
    get new_post_path
    assert_redirected_to posts_path
    get edit_post_path(@post)
    assert_redirected_to posts_path
  end

  test 'should not create post if unauthorized' do
    sign_out :user
    assert_no_difference('Post.count') do
      post posts_path, params: { post: {
        title: @post.title,
        body: @post.body,
        post_category_id: @post.post_category.id
      } }
    end
  end

  test 'should create post' do
    assert_difference('Post.count') do
      post posts_path, params: { post: {
        title: @post.title,
        body: @post.body,
        post_category_id: @post.post_category.id
      } }
    end
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
  end

  test 'should update post' do
    put post_path(@post), params: { post: {
      title: @post.title,
      body: 'New body',
      post_category_id: @post.post_category_id
    } }
    assert_redirected_to post_path(@post)
    assert Post.find(@post.id).body, 'New body'
  end

  # test 'should not destroy post' do
  #   sign_out :user
  #   assert_no_difference('Post.count') do
  #     delete post_path(@post)
  #   end
  # end

  # test 'should destroy post' do
  #   assert_difference('Post.count', -1) do
  #     delete post_path(@post)
  #   end
  #   assert_redirected_to posts_path
  # end
end
