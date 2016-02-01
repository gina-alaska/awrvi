require 'test_helper'

class IndicesFormsTest < ActionDispatch::IntegrationTest
  test 'a user can create an index' do
    visit(new_index_url)

  end
end
