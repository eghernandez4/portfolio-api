class Achievement < ApplicationRecord
  belongs_to :experience

  validates :title, presence: true
end
