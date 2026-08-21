# frozen_string_literal: true

FactoryBot.define do
  factory :project_skill do
    association :project
    association :skill
  end
end
