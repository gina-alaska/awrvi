class Community < ApplicationRecord
  include FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true
  validates :slug, uniqueness: true
end
