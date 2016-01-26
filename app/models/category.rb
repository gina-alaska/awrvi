class Category < ApplicationRecord
  has_closure_tree order: 'position'
  before_destroy :no_destroy

  has_many :choices, -> { order(index: :desc) }, dependent: :destroy
  has_many :indices

  def no_destroy
    false
  end
end
