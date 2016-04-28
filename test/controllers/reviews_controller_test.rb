require 'test_helper'

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @review = reviews(:one)
    login_as(users(:expert_reviewer))
  end

  test "should create review" do
    assert_difference('Review.count') do
      index = indices(:published)
      post index_reviews_url(index)
    end

    assert_redirected_to index_path(@review.index)
  end

  test "should destroy review" do
    assert_difference('Review.count', -1) do
      delete review_url(@review)
    end

    assert_redirected_to index_path(@review.index)
  end
end
