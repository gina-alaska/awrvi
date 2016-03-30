module PagesHelper
  def recent_indicies
    Index.published.recent
  end
end
