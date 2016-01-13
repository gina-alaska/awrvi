class Category < ApplicationRecord
  has_closure_tree order: 'position'
end
