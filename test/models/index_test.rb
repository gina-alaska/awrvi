# frozen_string_literal: true

require 'test_helper'

class IndexTest < ActiveSupport::TestCase
  setup do
    Category.rebuild!
  end

  def test_completeness
    {
      incomplete: '0 / 8',
      partial_complete: '4 / 8',
      complete: '8 / 8'
    }.each do |name, expected|
      index = indices(name)
      assert_equal expected, index.completeness
    end
  end

  def test_completeness_percentage
    {
      incomplete: 0.0,
      partial_complete: 50.0,
      complete: 100.0
    }.each do |name, expected|
      index = indices(name)
      assert_in_delta expected, index.completeness_percentage, 0.005, "#{name} should be #{expected}% complete"
    end
  end

  def test_vulnerability_index
    {
      incomplete: 0.0,
      partial_complete: 0.25,
      complete: 0.5
    }.each do |name, expected|
      index = indices(name)
      assert_in_delta expected, index.vulnerability_index, 0.005, "#{name} should have vulnerablity #{expected}"
    end
  end

  def test_publish
    @index = indices(:unpublished)

    assert @index.publish!
    assert_not_nil @index.published_at
  end

  def test_published?
    refute indices(:unpublished).published?
    assert indices(:published).published?
  end

  def test_publish_with_custom_time
    @index = indices(:unpublished)

    time = 1.month.ago
    assert @index.publish!(time)
    assert_equal time, @index.published_at
  end

  def test_should_return_true_if_reviewed
    @index = indices(:reviewed)

    assert @index.reviewed?, '@index.reviewed? returned false'
  end

  def test_should_return_false_if_reviewed
    @index = indices(:not_reviewed)

    assert_not @index.reviewed?, '@index.reviewed? returned true'
  end
end
