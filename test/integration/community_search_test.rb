require 'test_helper'

class CommunitySearchTest < ActionDispatch::IntegrationTest
  test 'Search for one community' do
    community = communities(:one)

    visit('/welcome')
    fill_in('q', with: community.name)
    click_button('search')

    assert page.has_content?("Name: #{community.name}")
  end

  test 'Search for multiple communities' do
    visit('/welcome')
    fill_in('q', with: 'Test')
    click_button('search')

    assert page.has_content?("Test")
    assert page.has_content?("Testing")
  end
end
