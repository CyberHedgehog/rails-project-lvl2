# frozen_string_literal: true

require 'test_helper'

class PostCommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @post = posts(:one)
    @comment = post_comments(:one)
    @new_comment_content = Faker::Lorem.sentences.join(' ')
    sign_in users(:one)
  end

  test 'should create comment' do
    post post_comments_path(@post), params: { post_comment: {
      content: @new_comment_content
    } }
    new_comment = PostComment.find_by(content: @new_comment_content)
    assert new_comment
    assert_redirected_to post_path(@post)
  end

  test 'should not create comment if unauthorized' do
    sign_out :user
    post post_comments_path(@post), params: { post_comment: {
      content: @new_comment_content
    } }
    new_comment = PostComment.find_by(content: @new_comment_content)
    assert_not new_comment
    assert_redirected_to new_user_session_path
  end
end
