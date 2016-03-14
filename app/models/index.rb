class Index < ApplicationRecord
  belongs_to :community
  belongs_to :category
  belongs_to :user
  belongs_to :awrvi_version, class_name: Category
  has_many :index_category_choices, dependent: :destroy
  has_many :choices, through: :index_category_choices

  accepts_nested_attributes_for :index_category_choices

  validate presence: :community_id
end
