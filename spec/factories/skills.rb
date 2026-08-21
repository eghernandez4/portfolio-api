# frozen_string_literal: true

FactoryBot.define do
  factory :skill do
    sequence(:name) { |n| "Skill #{n}" }
    category { 'Backend' }
    level { 'Expert' }
    years { 5 }
    display_order { 1 }
  end
end
