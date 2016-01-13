require 'test_helper'

class CommunitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @community = communities(:one)
  end

  test "should get index" do
    get communities_url
    assert_response :success
  end

  test "should get new" do
    get new_community_url
    assert_response :success
  end

  test "should create community" do
    assert_difference('Community.count') do
      post communities_url, params: { community: { census_id: @community.census_id, gnis_id: @community.gnis_id, location: @community.location, name: @community.name } }
    end

    assert_redirected_to community_path(Community.last)
  end

  test "should show community" do
    get community_url(@community)
    assert_response :success
  end

  test "should get edit" do
    get edit_community_url(@community)
    assert_response :success
  end

  test "should update community" do
    patch community_url(@community), params: { community: { census_id: @community.census_id, gnis_id: @community.gnis_id, location: @community.location, name: @community.name } }
    assert_redirected_to community_path(@community)
  end

  test "should destroy community" do
    assert_difference('Community.count', -1) do
      delete community_url(@community)
    end

    assert_redirected_to communities_path
  end
end
