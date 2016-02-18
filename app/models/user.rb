class User < ApplicationRecord
  include UserDevise
  extend FriendlyId

  friendly_id :slug_candidates, use: :slugged

  has_many :indices

  def slug_candidates
    [
      [:id, :name]
    ]
  end
end
