module CommunitiesHelper
  def sidebar_css(truthy)
    truthy ? 'with-sidebar' : 'without-sidebar'
  end

  def latest_awrvi_dashboard(community)
    published_dashboards(community).recent.first
  end

  def published_dashboards(community, opts = {})
    indices = community.indices.published
    if opts.include?(:exclude)
      indices = indices.where.not(id: opts[:exclude])
    end

    indices
  end
end
