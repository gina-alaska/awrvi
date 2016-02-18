require 'test_helper'

class ChoiceTest < ActiveSupport::TestCase
  setup do
    @choice = choices(:low)
  end

  test "no_destroy should return false" do
    refute @choice.no_destroy
  end

  test "to_s must return choice description" do
    assert_equal @choice.description, @choice.to_s
  end
end
