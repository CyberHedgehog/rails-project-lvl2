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
end
