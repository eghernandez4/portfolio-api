class Skill < ApplicationRecord
  has_many :experience_skills, dependent: :destroy
  has_many :experiences, through: :experience_skills
  has_many :project_skills, dependent: :destroy
  has_many :projects, through: :project_skills

  validates :name, presence: true, uniqueness: true
  validates :display_order, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :years, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
end
