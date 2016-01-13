class Category < ApplicationRecord
  has_closure_tree order: 'sort_order'

  has_many :choices, -> { order(index: :desc) }, dependent: :destroy 
end
