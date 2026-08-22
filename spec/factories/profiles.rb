# frozen_string_literal: true

FactoryBot.define do
  factory :profile do
    name { 'Eduar Hernández' }
    headline { 'Senior Ruby Developer' }
    bio { 'Backend engineer' }
    email { 'test@example.com' }
    location { 'Colombia' }
  end
end
