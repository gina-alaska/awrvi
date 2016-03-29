module PagesHelper
  def recent_indicies
    Index.available.recent
  end
end
