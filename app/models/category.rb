class Category < ApplicationRecord
  has_closure_tree order: 'position'

  has_many :choices, -> { order(index: :desc) }, dependent: :destroy
end
