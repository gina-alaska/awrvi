require 'test_helper'

class IndicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    Category.rebuild!
    @index = indices(:incomplete)
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
    login_as(users(:two))
    get edit_index_url(@index)
    assert_response :success
  end

  test "should update index" do
    login_as(users(:two))
    patch index_url(@index), params: {
      index: {
        awrvi_index: @index.awrvi_index,
        index_category_choices_attributes: {
          "0": {
            category: categories(:leaf_1),
            choice: categories(:leaf_1).choices.first
          }
        }
      }
    }
    assert_redirected_to index_path(@index)
  end

  test "should destroy index" do
    login_as(users(:two))
    assert_difference('Index.count', -1) do
      delete index_url(@index)
    end

    assert_redirected_to community_path(@index.community)
  end

  test "user should be able to publish their own index" do
    login_as(users(:two))
    patch publish_index_url(@index)
    assert_redirected_to index_path(@index)
  end

  test "user can not delete published indices" do
    login_as(users(:two))

    assert_difference('Index.count', 0) do
      delete index_url(indices(:published))
    end
  end
end
