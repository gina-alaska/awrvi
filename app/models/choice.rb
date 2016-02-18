class Choice < ApplicationRecord
  belongs_to :category
  before_destroy :no_destroy

  has_many :index_choices
  has_many :indicies, through: :index_choices

  def no_destroy
    false
  end

  def to_s
    description
  end
end
