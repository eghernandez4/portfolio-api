module Api::V1
  class ProfileController < ApplicationController
    def index
      profile = Profile.first

      if profile
        render json: ProfileSerializer.new(profile).serialize
      else
        render json: { error: "Profile not found" }, status: :not_found
      end
    end
  end
end
