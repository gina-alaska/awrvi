require 'test_helper'

class IndicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @index = indices(:one)
  end

  test "should get index" do
    get community_indices_url(communities(:one))
    assert_response :success
  end

  test "should get new" do
    login_as(users(:one))
    get community_indices_url(communities(:one))
    assert_response :success
  end

  test "should create index" do
    login_as(users(:one))
    assert_difference('Index.count') do
      post community_indices_url(communities(:one)), params: {
        index: {
          awrvi_index: @index.awrvi_index,
          finalized_at: @index.finalized_at,
          rejected_at: @index.rejected_at,
          rejected_reason: @index.rejected_reason,
          awrvi_version_id: @index.awrvi_version.id,
          index_category_choices_attributes: {
            "0": {
              category: categories(:one),
              choice: categories(:one).choices.first
            }
          }
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
    login_as(users(:one))
    get edit_index_url(@index)
    assert_response :success
  end

  test "should update index" do
    login_as(users(:one))
    patch index_url(@index), params: {
      index: {
        awrvi_index: @index.awrvi_index,
        finalized_at: @index.finalized_at,
        rejected_at: @index.rejected_at,
        rejected_reason: @index.rejected_reason,
        index_category_choices_attributes: {
          "0": {
            category: categories(:one),
            choice: categories(:one).choices.first
          }
        }
      }
    }
    assert_redirected_to index_path(@index)
  end

  test "should destroy index" do
    login_as(users(:one))
    assert_difference('Index.count', -1) do
      delete index_url(@index)
    end

    assert_redirected_to community_path(@index.community)
  end
end
