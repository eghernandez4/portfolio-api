class ExperienceSkill < ApplicationRecord
  belongs_to :experience
  belongs_to :skill

  validates :skill_id, uniqueness: { scope: :experience_id }
end
