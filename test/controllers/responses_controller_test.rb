require 'test_helper'

class ResponsesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @response = responses(:one)
  end

  test "should get index" do
    get responses_url
    assert_response :success
  end

  test "should get new" do
    get new_response_url
    assert_response :success
  end

  test "should create response" do
    assert_difference('Response.count') do
      post responses_url, params: { response: { awrvi_index: @response.awrvi_index, awrvi_text: @response.awrvi_text, raw_value: @response.raw_value } }
    end

    assert_redirected_to response_path(Response.last)
  end

  test "should show response" do
    get response_url(@response)
    assert_response :success
  end

  test "should get edit" do
    get edit_response_url(@response)
    assert_response :success
  end

  test "should update response" do
    patch response_url(@response), params: { response: { awrvi_index: @response.awrvi_index, awrvi_text: @response.awrvi_text, raw_value: @response.raw_value } }
    assert_redirected_to response_path(@response)
  end

  test "should destroy response" do
    assert_difference('Response.count', -1) do
      delete response_url(@response)
    end

    assert_redirected_to responses_path
  end
end
