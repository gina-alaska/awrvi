class Choice < ApplicationRecord
  belongs_to :category
  before_destroy :no_destroy

  has_many :index_choices
  has_many :indicies, through: :index_choices

  def no_destroy
    false
  end

  def to_s
    description
  end

  def human_score
    case index
    when 0
      'Highly vulnerable'
    when 0.25
      'Moderately vulnerable'
    when 0.5
      'Threshold'
    when 0.75
      'Moderately resilient'
    when 1.0
      'Highly resilient'
    end
  end

  def description
    "#{super} (#{human_score})"
  end
end
