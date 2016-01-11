class Category < ApplicationRecord
  has_closure_tree order: 'sort_order'
end
