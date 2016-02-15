require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should show user" do
    assert_raises CanCan::AccessDenied do
      get user_url(@user)
    end
  end

  test "should get edit" do
    assert_raises CanCan::AccessDenied do
      get edit_user_url(@user)
    end
  end

  test "should update user" do
    assert_raises CanCan::AccessDenied do
      patch user_url(@user), params: { user: { user_admin: true } }
    end
  end

  test "should destroy user" do
    assert_raises CanCan::AccessDenied do
      delete user_url(@user)
    end
  end
end
