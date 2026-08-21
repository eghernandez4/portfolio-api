# frozen_string_literal: true

# frozen_string_literal: true

module Api
  module V1
    class SkillsController < ApplicationController
      def index
        render json: SkillSerializer.new(Skill.all).serialize
      end
    end
  end
end
