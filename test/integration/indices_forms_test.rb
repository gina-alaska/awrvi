require 'test_helper'

class IndicesFormsTest < ActionDispatch::IntegrationTest
  test 'a user can create an index' do
    login_as(users(:one))
    choice = choices(:med)
    visit(new_community_index_path(communities(:one)))

    select(choice.description, from: choice.category.name)
    click_on('Create Index')

    assert page.has_content?("#{choice.category.name} #{choice.index}")
  end
end
