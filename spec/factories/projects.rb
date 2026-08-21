# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    association :experience
    name { 'Portfolio API' }
    description { 'Ruby on Rails backend' }
    display_order { 1 }
  end
end
