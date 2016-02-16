require 'test_helper'
class CategoryTest < ActiveSupport::TestCase
  setup do
    @category = categories(:one)
  end

  test "no_destroy should return false" do
    refute @category.no_destroy
  end

  test "to_s must return category name" do
    assert_equal @category.name, @category.to_s, "to_s failed and is not equal to name"
  end
end
