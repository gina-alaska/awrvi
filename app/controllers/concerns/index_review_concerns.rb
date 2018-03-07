# frozen_string_literal: true

module IndexReviewConcerns
  extend ActiveSupport::Concern

  def fetch_users_review_for_index
    return if @index.nil?
    @review = @index.reviews.accessible_by(current_ability, :manage).first
    @review ||= @index.reviews.build
  end
end
