class ExperienceSerializer
  include Alba::Serializer

  attributes :id,
             :company,
             :current,
             :employment_type,
             :start_date,
             :end_date,
             :position,
             :summary

  many :projects, serializer: ProjectSerializer, if: proc { params[:include_projects] }
  many :achievements, serializer: AchievementSerializer, if: proc { params[:include_achievements] }
  many :skills, serializer: SkillSerializer, if: proc { params[:include_skills] }
end
