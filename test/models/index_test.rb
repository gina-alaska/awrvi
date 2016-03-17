require 'test_helper'

class IndexTest < ActiveSupport::TestCase
  setup do
    Category.rebuild!
  end

  def test_completeness
    {
      incomplete: 0.0,
      partial_complete: 50.0,
      complete: 100.0
    }.each do |name, expected|
      index = indices(name)
      assert_in_delta expected, index.completeness, 0.005, "#{name} should be #{expected}% complete"
    end
  end

  def test_vulnerability_index
    {
      incomplete: 0.0,
      partial_complete: 0.5,
      complete: 0.5
    }.each do |name, expected|
      index = indices(name)
      assert_in_delta expected, index.vulnerability_index, 0.005, "#{name} should have vulnerablity #{expected}"
    end
  end
end
