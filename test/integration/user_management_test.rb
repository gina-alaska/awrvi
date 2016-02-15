require 'test_helper'

class UserManagementTest < ActionDispatch::IntegrationTest
  def test_admins_can_edit_users
    login(:admin)
    visit users_path
    assert page.has_content?('User One')

    click_on('User One edit link')
    check('Can Manage Users')
    click_button("Update User")

    assert page.has_content?("User One updated")
  end

end
