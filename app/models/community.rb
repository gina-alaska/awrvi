class Community < ApplicationRecord
  include CommunityConcerns
  include FriendlyId
  friendly_id :name, use: :slugged
  paginates_per 12

  has_many :indices

  validates :name, presence: true
  validates :slug, uniqueness: true

  def to_s
    name
  end
end
