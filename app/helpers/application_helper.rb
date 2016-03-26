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
    icc = index.index_category_choices.select { |ic| ic.category_id == category.id }

    icc.first || index.index_category_choices.build(category: category)
  end

  def devise_resource_name
    :user
  end

  def devise_resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  # Proxy to devise map class
  def devise_resource_class
    devise_mapping.to
  end
end
