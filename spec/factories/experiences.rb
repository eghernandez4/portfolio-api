# frozen_string_literal: true

FactoryBot.define do
  factory :experience do
    company { 'Cluvi' }
    position { 'Ruby Developer' }
    start_date { Date.today - 1.year }
    end_date { Date.today }
    summary { 'Backend developer' }
    display_order { 1 }
    current { false }

    trait :current do
      current { true }
      end_date { nil }
    end
  end
end
