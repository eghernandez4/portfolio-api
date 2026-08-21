# frozen_string_literal: true

FactoryBot.define do
  factory :experience_skill do
    association :experience
    association :skill
  end
end
