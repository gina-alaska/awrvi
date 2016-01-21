require 'test_helper'

class ChoicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @choice = choices(:one)
  end

  test "should get index" do
    get choices_url
    assert_response :success
  end

  test "should get new" do
    get new_choice_url
    assert_response :success
  end

  test "should create choice" do
    assert_difference('Choice.count') do
      post choices_url, params: { choice: { category_id: @choice.category_id, description: @choice.description, index: @choice.index } }
    end

    assert_redirected_to choice_path(Choice.last)
  end

  test "should show choice" do
    get choice_url(@choice)
    assert_response :success
  end

  test "should get edit" do
    get edit_choice_url(@choice)
    assert_response :success
  end

  test "should update choice" do
    patch choice_url(@choice), params: { choice: { category_id: @choice.category_id, description: @choice.description, index: @choice.index } }
    assert_redirected_to choice_path(@choice)
  end

  test "should destroy choice" do
    assert_difference('Choice.count', -1) do
      delete choice_url(@choice)
    end

    assert_redirected_to choices_path
  end
end