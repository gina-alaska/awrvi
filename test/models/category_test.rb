# frozen_string_literal: true

require 'test_helper'
class CategoryTest < ActiveSupport::TestCase
  setup do
    @category = categories(:root)
  end

  test "no_destroy should return false" do
    refute @category.no_destroy
  end

  test "to_s must return category name" do
    assert_equal @category.name, @category.to_s
  end
end
