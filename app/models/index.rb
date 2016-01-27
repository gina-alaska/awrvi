class Index < ApplicationRecord
  belongs_to :community
  belongs_to :category
  has_many :index_choices, dependent: :destroy
  has_many :choices, through: :index_choices
end
