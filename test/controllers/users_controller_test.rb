require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  teardown do
    Warden.test_reset!
  end

  test "should get index" do
    get manage_users_url
    assert_response :success
  end

  test "can't view other users" do
    assert_raises CanCan::AccessDenied do
      get profile_url(@user)
    end
  end

  test 'users can view themsleves' do
    login_as(@user)
    get profile_url(@user)
    assert_response :success
  end

  test "can't edit other users" do
    assert_raises CanCan::AccessDenied do
      get edit_manage_user_url(@user)
    end
  end

  test 'can edit themselves' do
    login_as(@user)
    get profile_url(@user)
    assert_response :success
  end

  test "should update user" do
    assert_raises CanCan::AccessDenied do
      patch manage_user_url(@user), params: { user: { user_admin: true } }
    end
  end

  test "should destroy user" do
    assert_raises CanCan::AccessDenied do
      delete manage_user_url(@user)
    end
  end

  test 'manage interface sets the right variant' do
    login_as(users(:admin), scope: :user)
    get manage_user_url(@user)
    assert_includes controller.request.variant, :'user-admin'
  end

  test 'admins can update user abilities' do
    login_as(users(:admin), scope: :user)
    patch manage_user_url(@user), params: { user: {user_admin: true } }
    assert_redirected_to manage_user_path(@user)
  end
end
