module IndicesHelper
  def indicator_percentage(index, indicator)
    leaves = indicator.leaves.pluck(:id)
    percentage = index.choices.where(category: leaves).sum(:index) / leaves.count
    percentage * 100
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
