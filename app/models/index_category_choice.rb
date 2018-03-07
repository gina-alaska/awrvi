# frozen_string_literal: true

class IndexCategoryChoice < ApplicationRecord
  belongs_to :index
  belongs_to :choice
  belongs_to :category
end
