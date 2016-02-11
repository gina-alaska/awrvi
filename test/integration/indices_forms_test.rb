require 'test_helper'

class IndicesFormsTest < ActionDispatch::IntegrationTest
  test 'a user can create an index' do
    choice = choices(:med)
    visit(new_index_path)

    select(choice.description, from: choice.category.name)
    click_on('Create Index')

    assert page.has_content?("#{choice.category.name}: #{choice.index}")
  end
end
