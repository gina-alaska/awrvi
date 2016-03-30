require 'test_helper'

class Manage::IndicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as(users(:index_admin))
    @index = indices(:one)
  end

  teardown do
    Warden.test_reset!
  end

  test "edit indices" do
    get edit_manage_index_url(@index)
    assert_response :success
  end

  test "should hide index" do
    patch manage_index_url(@index), params: { index: { hidden_reason: "Test" } }
    assert_redirected_to communities_path
  end
end
