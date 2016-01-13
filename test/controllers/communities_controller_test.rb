require 'test_helper'

class CommunityControllerTest < ActionDispatch::IntegrationTest
  setup do
    @community = communities(:one)
  end

  test 'should get index' do
    get communities_url
    assert_response :success
  end

  test 'should get show' do
    get community_url(@community)
    assert_response :success
  end

  test "should get new" do
    get new_community_url
    assert_response :success
  end

  test "should create community" do
    assert_difference('Community.count') do
      post communities_url, params: { community: { name: "test", gnis_id: @community.gnis_id, location: @community.location } }
    end

    assert_redirected_to community_path(Community.last)
  end

  test "should get edit" do
    get edit_community_url(@community)
    assert_response :success
  end

  test "should update community" do
    patch community_url(@community), params: { community: { name: @community.name, gnis_id: @community.gnis_id, location: @community.location } }
    assert_redirected_to community_path(@community)
  end

  test "should destroy community" do
    assert_difference('Community.count', -1) do
      delete community_url(@community)
    end

    assert_redirected_to communities_path
  end
end
