require 'test_helper'

class IndicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @index = indices(:one)
  end

  test "should get index" do
    get indices_url
    assert_response :success
  end

  test "should get new" do
    get new_index_url
    assert_response :success
  end

  test "should create index" do
    assert_difference('Index.count') do
      post indices_url, params: {
        index: {
          awrvi_index: @index.awrvi_index,
          finalized_at: @index.finalized_at,
          rejected_at: @index.rejected_at,
          rejected_reason: @index.rejected_reason
        }
      }
    end

    assert_redirected_to index_path(Index.last)
  end

  test "should show index" do
    get index_url(@index)
    assert_response :success
  end

  test "should get edit" do
    get edit_index_url(@index)
    assert_response :success
  end

  test "should update index" do
    patch index_url(@index), params: {
      index: {
        awrvi_index: @index.awrvi_index,
        finalized_at: @index.finalized_at,
        rejected_at: @index.rejected_at,
        rejected_reason: @index.rejected_reason
      }
    }
    assert_redirected_to index_path(@index)
  end

  test "should destroy index" do
    assert_difference('Index.count', -1) do
      delete index_url(@index)
    end

    assert_redirected_to indices_path
  end
end
