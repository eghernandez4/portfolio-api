# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "Seeding data..."

# Clean up existing records in reverse dependency order to avoid FK violation issues
ProjectSkill.destroy_all
ExperienceSkill.destroy_all
Achievement.destroy_all
Project.destroy_all
Experience.destroy_all
Skill.destroy_all
Profile.destroy_all

# 1. Create Profile singleton
profile = Profile.create!(
  name: "Eduar Hernández",
  headline: "Senior Ruby Developer",
  bio: "Backend engineer especializado en Rails, MongoDB y AWS con amplia experiencia diseñando arquitecturas escalables, integraciones de sistemas POS y optimización de ETLs.",
  location: "Colombia",
  email: "eduar@example.com",
  linkedin_url: "https://linkedin.com/in/eghernandez4",
  github_url: "https://github.com/eghernandez4",
  website_url: "https://eduar.dev"
)
puts "Created Profile: #{profile.name}"

# 2. Create Skills
rails_skill = Skill.create!(name: "Ruby on Rails", category: "Backend", level: "Expert", years: 8, display_order: 1)
ruby_skill = Skill.create!(name: "Ruby", category: "Backend", level: "Expert", years: 10, display_order: 2)
mongodb_skill = Skill.create!(name: "MongoDB", category: "Database", level: "Senior", years: 5, display_order: 3)
redis_skill = Skill.create!(name: "Redis", category: "Database", level: "Senior", years: 6, display_order: 4)
aws_glue_skill = Skill.create!(name: "AWS Glue", category: "DevOps/Data", level: "Mid", years: 2, display_order: 5)
athena_skill = Skill.create!(name: "AWS Athena", category: "DevOps/Data", level: "Mid", years: 2, display_order: 6)
aws_skill = Skill.create!(name: "AWS", category: "DevOps", level: "Senior", years: 4, display_order: 7)

puts "Created #{Skill.count} skills."

# 3. Create Experiences
otto_exp = Experience.create!(
  company: "Otto",
  position: "Senior Ruby Developer",
  employment_type: "full_time",
  start_date: Date.new(2022, 3, 1),
  current: true,
  summary: "Desarrollé integraciones POS, ETLs automatizados, microservicios orientados a eventos y optimicé el procesamiento de datos a gran escala utilizando tecnologías AWS y MongoDB.",
  display_order: 1
)

tech_corp_exp = Experience.create!(
  company: "Tech Corp",
  position: "Ruby Developer",
  employment_type: "full_time",
  start_date: Date.new(2018, 5, 1),
  end_date: Date.new(2022, 2, 28),
  current: false,
  summary: "Lideré el desarrollo de módulos clave para la plataforma e-commerce principal de la compañía, implementando APIs REST rápidas y seguras.",
  display_order: 2
)

puts "Created #{Experience.count} experiences."

# 4. Associate Skills with Experiences
[ rails_skill, ruby_skill, mongodb_skill, redis_skill, aws_skill ].each do |skill|
  ExperienceSkill.create!(experience: otto_exp, skill: skill)
end

[ rails_skill, ruby_skill, redis_skill ].each do |skill|
  ExperienceSkill.create!(experience: tech_corp_exp, skill: skill)
end

puts "Associated skills with experiences."

# 5. Create Achievements
Achievement.create!(
  experience: otto_exp,
  title: "Reducción de tiempo ETL",
  impact: "40%",
  description: "Optimicé el pipeline de carga de datos (ETL) migrando consultas ineficientes de MongoDB a AWS Glue y Athena, reduciendo el tiempo de procesamiento mensual en un 40%."
)

Achievement.create!(
  experience: otto_exp,
  title: "Migración de Sistema POS",
  impact: "99.9% uptime",
  description: "Diseñé y lideré la migración del sistema POS principal a una arquitectura distribuida tolerante a fallos de red."
)

puts "Created achievements."

# 6. Create Projects
pos_project = Project.create!(
  experience: otto_exp,
  name: "Sistema POS Otto",
  description: "Sistema distribuido para la sincronización en tiempo real de transacciones de puntos de venta con el backend corporativo.",
  repository_url: "https://github.com/eghernandez4/otto-pos",
  demo_url: "https://pos.otto.example.com",
  start_date: Date.new(2022, 6, 1),
  end_date: Date.new(2023, 12, 31),
  display_order: 1
)

etl_project = Project.create!(
  experience: otto_exp,
  name: "Pipeline de Reportes Analíticos",
  description: "ETL de procesamiento de eventos en batch con AWS Glue, Athena y almacenamiento optimizado en S3.",
  start_date: Date.new(2023, 1, 15),
  display_order: 2
)

puts "Created projects."

# 7. Associate Skills with Projects
[ rails_skill, redis_skill, mongodb_skill, aws_skill ].each do |skill|
  ProjectSkill.create!(project: pos_project, skill: skill)
end

[ aws_glue_skill, athena_skill, aws_skill, ruby_skill ].each do |skill|
  ProjectSkill.create!(project: etl_project, skill: skill)
end

puts "Associated skills with projects."
puts "Database successfully seeded!"
