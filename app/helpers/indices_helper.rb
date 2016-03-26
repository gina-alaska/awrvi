module IndicesHelper
  def indicator_value(index, indicator)
    leaves = indicator.leaves.pluck(:id)
    index.choices.where(category: leaves).sum(:index) / leaves.count
  end

  def progress_bar_for_percentage(percentage)
    case
    when percentage >= 60
      'progress-bar-success'
    when percentage >= 30
      'progress-bar-warning'
    else
      'progress-bar-danger'
    end
  end
end
