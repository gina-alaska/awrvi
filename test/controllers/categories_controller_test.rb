require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    Category.rebuild!
    @category = categories(:root)
    login_as(users(:category_admin))
  end

  test "should get index" do
    get categories_url
    assert_response :success
  end

  test "should get new" do
    get new_category_url
    assert_response :success
  end

  test "should create category" do
    assert_difference('Category.count') do
      post categories_url, params: { category: { name: @category.name, position: @category.position, parent_id: @category.parent_id } }
    end

    assert_redirected_to category_path(Category.last)
  end

  test "should show category" do
    get category_url(@category)
    assert_response :success
  end

  test "should get edit" do
    get edit_category_url(@category)
    assert_response :success
  end

  test "should update category" do
    patch category_url(@category), params: { category: { name: @category.name, position: @category.position, parent_id: @category.parent_id } }
    assert_redirected_to category_path(@category)
  end

  test "should not destroy category" do
    assert_raises ActionController::RoutingError do
      delete category_url(@category)
    end
  end
end
