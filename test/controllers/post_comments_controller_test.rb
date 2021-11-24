# frozen_string_literal: true

require 'test_helper'

class PostCommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @post = posts(:one)
    @comment = post_comments(:one)
    sign_in users(:one)
  end

  test 'should create comment' do
    assert_difference('PostComment.count') do
      post post_comments_path(@post), params: { post_comment: {
        content: @comment.content
      } }
    end
    assert_redirected_to post_path(@post)
  end
end
