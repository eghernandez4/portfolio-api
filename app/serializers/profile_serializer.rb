class ProfileSerializer
  include Alba::Serializer

  attributes :id,
             :name,
             :headline,
             :bio,
             :email,
             :github_url,
             :linkedin_url,
             :website_url,
             :location
end
