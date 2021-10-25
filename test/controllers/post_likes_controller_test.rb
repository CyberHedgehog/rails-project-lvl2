require "test_helper"

class PostLikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @post = posts(:one)
    sign_in users(:one)
    @like = post_likes(:one)
  end

  test 'should like post' do
    assert_difference('PostLike.count') do
      post post_likes_path(@post)
    end
    assert_redirected_to post_path(@post)
  end

  test 'should unlike post' do
    assert_difference('PostLike.count', -1) do
      delete post_like_path(post_id: @post.id, id: @like.id)
    end
    assert_redirected_to post_path(@post)
  end
end
