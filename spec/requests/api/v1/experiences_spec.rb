# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Experiences', type: :request do
  describe 'GET /api/v1/experiences' do
    let!(:skill) { create(:skill, name: 'Ruby on Rails', category: 'Backend', display_order: 1) }
    let!(:experience) { create(:experience) }
    let!(:achievement) do
      create(
        :achievement,
        experience: experience,
        title: 'Built Microservice',
        description: 'High performance API'
      )
    end
    let!(:project) do
      create(
        :project,
        experience: experience,
        name: 'Portfolio API',
        display_order: 1
      )
    end

    before do
      create(:experience_skill, experience: experience, skill: skill)
      create(:project_skill, project: project, skill: skill)
    end

    it 'returns projects when is requested' do
      get '/api/v1/experiences?projects=true&skills=true'
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body.first['projects']).to be_present
      expect(response.parsed_body.first['skills']).to be_present
    end
  end
end
