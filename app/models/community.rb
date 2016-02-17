class Community < ApplicationRecord
  include FriendlyId
  friendly_id :name, use: :slugged

  has_many :indices
  
  validates :name, presence: true
  validates :slug, uniqueness: true
end
