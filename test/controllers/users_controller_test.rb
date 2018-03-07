# frozen_string_literal: true

require 'test_helper'

module ManageUserControllerTests
  class UserAdminTest < ActionDispatch::IntegrationTest
    setup do
      login_as(users(:user_admin))
      @user = users(:one)
    end

    teardown do
      Warden.test_reset!
    end

    test "should get index" do
      get manage_users_url
      assert_response :success
    end

    test 'manage interface sets the right variant' do
      login_as(users(:user_admin), scope: :user)
      get manage_user_url(@user)
      assert_includes controller.request.variant, :'user-admin'
    end

    test 'admins can update user abilities' do
      login_as(users(:user_admin), scope: :user)
      patch manage_user_url(@user), params: { user: { user_admin: true } }
      assert_redirected_to manage_user_path(@user)
    end
  end

  class UserProfileTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:one)
    end

    teardown do
      Warden.test_reset!
    end

    test "can't view other users" do
      get profile_url(@user)
      assert_redirected_to new_user_session_path
    end

    test 'users can view themsleves' do
      login_as(@user)
      get profile_url(@user)
      assert_response :success
    end

    test "can't edit other users" do
      get edit_manage_user_url(@user)
      assert_redirected_to new_user_session_path
    end

    test 'can edit themselves' do
      login_as(@user)
      get profile_url(@user)
      assert_response :success
    end

    test "should not update user" do
      patch manage_user_url(@user), params: { user: { user_admin: true } }
      assert_redirected_to new_user_session_path
    end

    test "should not destroy user" do
      delete manage_user_url(@user)
      assert_redirected_to new_user_session_path
    end
  end
end
