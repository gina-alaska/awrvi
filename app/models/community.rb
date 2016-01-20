class Community < ApplicationRecord
  include FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true
  validates_uniqueness_of :slug
end
