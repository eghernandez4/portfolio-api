class Profile < ApplicationRecord
  before_validation :set_singleton_guard

  validates :name, presence: true
  validates :headline, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validate :only_one_profile, on: :create

  private

  def set_singleton_guard
    self.singleton_guard = 1
  end

  def only_one_profile
    if Profile.exists?
      errors.add(:base, "Only one profile is allowed in the system")
    end
  end
end
