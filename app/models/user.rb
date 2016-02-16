class User < ApplicationRecord
  include UserDevise

  has_many :indices
end
