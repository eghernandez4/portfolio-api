# frozen_string_literal: true

module Api
  module V1
    class ExperiencesController < ApplicationController
      def index
        experiences = experiences_scope

        render json: ExperienceSerializer.new(experiences, params: serialization_params).serialize
      end

      private

      def experiences_scope
        scope = Experience.order(display_order: :asc)
        associations = []
        associations << :achievements if params.has_key?("achievements")
        associations << :skills if params.has_key?("skills")

        scope = scope.includes(projects: [ :skills, { project_skills: :skill } ]) if params.has_key?("projects")
        scope.includes(associations)
      end

      def serialization_params
        {
          include_projects: params.has_key?("projects"),
          include_achievements: params.has_key?("achievements"),
          include_skills: params.has_key?("skills")
        }
      end
    end
  end
end
