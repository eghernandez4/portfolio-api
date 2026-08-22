# frozen_string_literal: true

FactoryBot.define do
  factory :achievement do
    association :experience
    title { 'Built Microservice' }
    description { 'High performance API' }
    impact { 'Increased throughput' }
  end
end
