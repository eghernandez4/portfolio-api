# frozen_string_literal: true

# frozen_string_literal: true

module Api
  module V1
    class ProjectsController < ApplicationController
      def index
        render json: ProjectSerializer.new(Project.all).serialize
      end
    end
  end
end
