class Category < ApplicationRecord
  has_closure_tree order: 'position'
  before_destroy :no_destroy

  has_many :choices, -> { order(index: :asc) }, dependent: :destroy
  has_many :indices

  scope :active_root, -> { where(name: "AWRVI 2.0") }

  def no_destroy
    false
  end

  def to_s
    name
  end
end
