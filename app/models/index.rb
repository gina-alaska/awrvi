class Index < ApplicationRecord
  belongs_to :community
  belongs_to :awrvi_version, class_name: Category
  has_many :index_choices, dependent: :destroy
  has_many :choices, through: :index_choices

  accepts_nested_attributes_for :choices
end
