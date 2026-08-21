class ProjectSerializer
  include Alba::Serializer

  attributes :id,
             :demo_url,
             :description,
             :display_order,
             :start_date,
             :end_date,
             :name,
             :repository_url

  many :skills, serializer: SkillSerializer, if: proc { params[:include_skills] }
end
