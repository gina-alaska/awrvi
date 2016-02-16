require 'test_helper'

class UserManagementTest < ActionDispatch::IntegrationTest
  def test_admins_can_edit_users
    target_user = users(:one)
    login(:admin)
    visit manage_users_path
    assert page.has_content?(target_user.name), 'Users not listed on page'

    click_on("manage_user_#{target_user.id}")
    check('User admin')
    click_button("Update user")

    assert page.has_content?("User was successfully updated.")
  end

end
