require 'rails_helper'

RSpec.describe "Api::V1::Profiles", type: :request do
  describe "GET /api/v1/profile" do
    context "when profile exists" do
      let!(:profile) do
        create(
          :profile,
          name: 'Eduar Hernández',
          headline: 'Senior Ruby Developer',
          bio: 'Backend Engineer',
          email: 'test@example.com',
          location: 'Colombia'
        )
      end

      it "returns 200 OK with the serialized profile" do
        get "/api/v1/profile"

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json["id"]).to eq(profile.id)
        expect(json["name"]).to eq('Eduar Hernández')
        expect(json["headline"]).to eq('Senior Ruby Developer')
        expect(json["email"]).to eq('test@example.com')
      end
    end

    context "when no profile exists" do
      it "returns 404 Not Found" do
        get "/api/v1/profile"

        expect(response).to have_http_status(:not_found)
        json = JSON.parse(response.body)
        expect(json["error"]).to eq('Profile not found')
      end
    end
  end
end
