require 'test_helper'

class CommunitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @community = communities(:with_index)
  end

  test 'should get index' do
    get communities_url
    assert_response :success
  end

  test 'should not get new' do
    get new_community_url
    assert_redirected_to new_user_session_path
  end

  test 'should not create community' do
    post communities_url, params: { community: { census_id: @community.census_id, gnis_id: @community.gnis_id, location: @community.location, name: @community.name } }
    assert_redirected_to new_user_session_path
  end

  test 'should show community' do
    get community_url(@community)
    assert_response :success
  end

  test 'should show community without any indexes' do
    get community_url(communities(:without_index))
    assert_response :success
  end

  test 'should not get edit' do
    get edit_community_url(@community)
    assert_redirected_to new_user_session_path
  end

  test 'should not update community' do
    patch community_url(@community), params: { community: { census_id: @community.census_id, gnis_id: @community.gnis_id, location: @community.location, name: @community.name } }
    assert_redirected_to new_user_session_path
  end

  test 'should not destroy community' do
    delete community_url(@community)
    assert_redirected_to new_user_session_path
  end

  test 'Search for one community' do
    community = communities(:one)

    get communities_url, params: { q: community.name }

    assert_response :redirect
    assert_redirected_to community_url(community)

    follow_redirect!
    assert_response :success
  end

  test 'Search for multiple communities' do
    get communities_url, params: { q: 'Test' }

    assert_response :success
  end
end
