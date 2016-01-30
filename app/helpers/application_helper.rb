module ApplicationHelper
  def bootstrap_flash_type(type)
    case type
    when 'notice'
      'success'
    when 'error'
      'danger'
    else
      'info'
    end
  end

  def category_choices(index, category)
    icc = index.index_category_choices.select{|icc| icc.category_id == category.id }

    icc.first || index.index_category_choices.build(category: category)
  end
end
