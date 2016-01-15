class Choice < ApplicationRecord
  belongs_to :category

  has_many :index_choices
  has_many :indicies, through: :index_choices
end
