require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end
  test 'get registration page' do
    get new_user_registration_path
    assert_response :success
  end

  test 'create user' do
    post user_registration_path, params: { user: {
      email: @user.email,
      password: @user.encrypted_password
    } }
    assert_redirected_to root_path
  end
end