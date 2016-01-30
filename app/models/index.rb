class Index < ApplicationRecord
  belongs_to :community
  belongs_to :category
  has_many :index_category_choices, dependent: :destroy
  has_many :choices, through: :index_category_choices

  accepts_nested_attributes_for :choices
end
