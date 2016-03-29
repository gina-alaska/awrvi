require 'test_helper'

class IndicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    Category.rebuild!
    @index = indices(:complete)
    @unfinalized = indices(:unfinalized)
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
              category: categories(:leaf_1),
              choice: categories(:leaf_1).choices.first
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
    get edit_index_url(@unfinalized)
    assert_response :success
  end

  test "should update index" do
    login_as(users(:one))
    patch index_url(@unfinalized), params: {
      index: {
        awrvi_index: @unfinalized.awrvi_index,
        index_category_choices_attributes: {
          "0": {
            category: categories(:leaf_1),
            choice: categories(:leaf_1).choices.first
          }
        }
      }
    }
    assert_redirected_to index_path(@unfinalized)
  end

  test "should destroy index" do
    login_as(users(:one))
    assert_difference('Index.count', -1) do
      delete index_url(@unfinalized)
    end

    assert_redirected_to community_path(@unfinalized.community)
  end

  test "should get finalize" do
    login_as(users(:one))
    patch finalize_index_url(@unfinalized)
    assert_redirected_to index_path(@unfinalized)
  end
end
