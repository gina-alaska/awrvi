class Index < ApplicationRecord
  belongs_to :community
<<<<<<< HEAD
  belongs_to :awrvi_version, class_name: Category
=======
  belongs_to :category
>>>>>>> cc56c5e4233bcb75a3ec0a5de52e9b45799092e9
  has_many :index_category_choices, dependent: :destroy
  has_many :choices, through: :index_category_choices

  accepts_nested_attributes_for :choices
end
