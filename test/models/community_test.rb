require 'test_helper'

class CommunityTest < ActiveSupport::TestCase
  test 'Should not save a community without a community name' do
    community = Community.new
    assert_not community.save
  end
end
