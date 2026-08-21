class SkillSerializer
  include Alba::Serializer

  attributes :id,
             :category,
             :display_order,
             :level,
             :name,
             :years
end
