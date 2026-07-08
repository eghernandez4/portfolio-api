class Experience < ApplicationRecord
  EMPLOYMENT_TYPES = %w[full_time part_time contract freelance internship self_employed].freeze

  has_many :projects, dependent: :destroy
  has_many :achievements, dependent: :destroy
  has_many :experience_skills, dependent: :destroy
  has_many :skills, through: :experience_skills

  before_validation :clear_end_date_if_current

  validates :company, presence: true
  validates :position, presence: true
  validates :start_date, presence: true
  validates :display_order, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :employment_type, inclusion: { in: EMPLOYMENT_TYPES }, allow_blank: true
  validates :current, inclusion: { in: [ true, false ] }

  validate :end_date_after_start_date
  validate :end_date_presence_if_not_current

  private

  def clear_end_date_if_current
    self.end_date = nil if current?
  end

  def end_date_after_start_date
    return if start_date.blank? || end_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after start date")
    end
  end

  def end_date_presence_if_not_current
    return if current?

    if end_date.blank?
      errors.add(:end_date, "must be present if it is not the current job")
    end
  end
end
