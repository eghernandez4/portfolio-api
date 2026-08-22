class Project < ApplicationRecord
  belongs_to :experience
  has_many :project_skills, dependent: :destroy
  has_many :skills, through: :project_skills

  validates :name, presence: true
  validates :display_order, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    return if start_date.blank? || end_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after start date")
    end
  end
end
