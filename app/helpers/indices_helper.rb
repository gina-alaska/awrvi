# frozen_string_literal: true

module IndicesHelper
  def indicator_value(index, indicator)
    leaves = indicator.leaves.pluck(:id)
    index.choices.where(category: leaves).sum(:index) / leaves.count
  end

  def progress_bar_for_percentage(percentage)
    if percentage >= 60
      'progress-bar-success'
    elsif percentage >= 30
      'progress-bar-warning'
    else
      'progress-bar-danger'
    end
  end

  def completed_count(index, categories)
    completed = IndexCategoryChoice.where(index: index, category: categories)
    completed = completed.where.not(choice_id: nil).count
    "#{completed} / #{categories.count}"
  end
end
