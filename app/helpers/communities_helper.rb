module CommunitiesHelper
  def sidebar_css(truthy)
    truthy ? 'with-sidebar' : 'without-sidebar'
  end
end
