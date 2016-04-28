require 'test_helper'

class CommunityTest < ActiveSupport::TestCase
  setup do
    @community = communities(:with_location)
  end

  test 'Should not save a community without a community name' do
    community = Community.new
    assert_not community.save
  end

  test 'should test for valid location' do
    assert @community.location?, 'Location was not valid'
    assert_not communities(:without_location).location?, 'Community without location was valid'
  end

  test 'should get geometry object' do
    assert_kind_of GeoRuby::SimpleFeatures::Geometry, @community.geometry
  end

  test 'should get latlng array' do
    assert_equal [64.8377778, -147.7163889], @community.latlng
  end

  test 'should get lnglat array' do
    assert_equal [-147.7163889, 64.8377778], @community.lnglat
  end

  test 'should return correct location format for url' do
    assert_match '-147.7163889,64.8377778,13/100x100', @community.static_map_url(13, '100x100')
  end

  test 'should return latest published index' do
    assert_equal indices(:multi_published_b), @community.current_index
  end
end
