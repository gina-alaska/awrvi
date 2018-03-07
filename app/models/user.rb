# frozen_string_literal: true

class User < ApplicationRecord
  include UserDevise
  extend FriendlyId

  friendly_id :slug_candidates, use: :slugged

  has_many :indices
  has_many :reviews

  def slug_candidates
    [
      %i[id name]
    ]
  end
end
