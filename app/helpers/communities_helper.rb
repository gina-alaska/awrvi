module CommunitiesHelper
  def sidebar_css(truthy)
    truthy ? 'with-sidebar' : 'without-sidebar'
  end

  def latest_vulnerability_assesment(community)
    published_assessments(community).recent.first
  end

  def published_assessments(community, opts = {})
    indices = community.indices.published
    indices = indices.where.not(id: opts[:exclude]) if opts.include?(:exclude)

    indices
  end
end
