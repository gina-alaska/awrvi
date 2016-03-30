class Index < ApplicationRecord
  belongs_to :community
  belongs_to :category
  belongs_to :user
  belongs_to :awrvi_version, class_name: Category
  has_many :index_category_choices, dependent: :destroy
  has_many :choices, through: :index_category_choices

  accepts_nested_attributes_for :index_category_choices

  validates :community_id, presence: true
  validates :hidden_reason, presence: { message: "Reason for hiding Index must be specified" },
              if: ->(i) { i.hidden? }
  validates :user_id, presence: true

  def completeness
    "#{choices.count} / #{awrvi_version.leaves.count}"
  end

  def completeness_percentage
    (choices.count.to_f / awrvi_version.leaves.count) * 100
  end

  def vulnerability_index
    return 0.0 if awrvi_version.leaves.count == 0
    return 0.0 if choices.count == 0
    choices.sum(:index) / awrvi_version.leaves.count
  end
end
