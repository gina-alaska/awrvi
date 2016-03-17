module CommunitiesHelper
  def main_column_css(has_sidebar)
    if has_sidebar
      'col-xs-9 col-sm-10'
    else
      'col-xs-12'
    end
  end
end