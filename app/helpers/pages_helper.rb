# frozen_string_literal: true

module PagesHelper
  def recent_indicies
    Index.published.recent
  end

  def recent_indicies_as_groups
    Index.published.recent.limit(18).each_slice(6).to_a
  end
end
