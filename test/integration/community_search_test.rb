require 'test_helper'

class CommunitySearchTest < ActionDispatch::IntegrationTest
  test 'Search for one community' do
    get '/welcome'
    assert_response :success
  end
end
