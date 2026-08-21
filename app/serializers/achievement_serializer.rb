class AchievementSerializer
  include Alba::Serializer

  attributes :id,
             :description,
             :impact,
             :title
end
