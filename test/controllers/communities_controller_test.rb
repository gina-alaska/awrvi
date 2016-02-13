require 'test_helper'

class CommunitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @community = communities(:one)
  end

  test 'should get index' do
    get communities_url
    assert_response :success
  end

  test 'should get new' do
    assert_raises CanCan::AccessDenied do
      get new_community_url
    end
  end

  test 'should create community' do
    assert_raises CanCan::AccessDenied do
      post communities_url, params: { community: { census_id: @community.census_id, gnis_id: @community.gnis_id, location: @community.location, name: @community.name } }
    end
  end

  test 'should show community' do
    get community_url(@community)
    assert_response :success
  end

  test 'should get edit' do
    assert_raises CanCan::AccessDenied do
      get edit_community_url(@community)
    end
  end

  test 'should update community' do
    assert_raises CanCan::AccessDenied do
      patch community_url(@community), params: { community: { census_id: @community.census_id, gnis_id: @community.gnis_id, location: @community.location, name: @community.name } }
    end
  end

  test 'should destroy community' do
    assert_raises CanCan::AccessDenied do
      delete community_url(@community)
    end
  end
end
