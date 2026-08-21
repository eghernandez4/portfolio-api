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

# 1. Create a Profile singleton
profile = Profile.create!(
  name: "Eduar Hernández",
  headline: "Senior Ruby Developer",
  bio: "Backend engineer especializado en Rails, MongoDB y AWS con amplia experiencia diseñando arquitecturas escalables, integraciones de sistemas POS y optimización de ETLs.",
  location: "Colombia",
  email: "eghernandez4@gmail.com",
  linkedin_url: "https://www.linkedin.com/in/eduar-hern%C3%A1ndez-262917bb/",
  github_url: "https://github.com/eghernandez4",
  website_url: "https://eduar.dev"
)
puts "Created Profile: #{profile.name}"

# 2. Create Skills
rails_skill = Skill.create!(name: "Ruby on Rails", category: "Backend", level: "Expert", years: 5, display_order: 1)
ruby_skill = Skill.create!(name: "Ruby", category: "Backend", level: "Expert", years: 5, display_order: 2)
python_skill = Skill.create!(name: "Python", category: "Backend", level: "Mid", years: 2, display_order: 3)
postgres_skill = Skill.create!(name: "PostgreSQL", category: "Database", level: "Senior", years: 5, display_order: 4)
mongodb_skill = Skill.create!(name: "MongoDB", category: "Database", level: "Senior", years: 4, display_order: 5)
redis_skill = Skill.create!(name: "Redis", category: "Database", level: "Senior", years: 4, display_order: 6)
rspec_skill = Skill.create!(name: "RSpec", category: "Backend", level: "Expert", years: 4, display_order: 7)
rabbit_queue_skill = Skill.create!(name: "RabbitMQ", category: "DevOps/Data", level: "Senior", years: 4, display_order: 8)
sinatra_skill = Skill.create!(name: "Sinatra", category: "Backend", level: "Mid", years: 2, display_order: 9)
angular_skill = Skill.create!(name: "AngularJS", category: "Frontend", level: "Mid", years: 2, display_order: 10)
vue_skill = Skill.create!(name: "Vue.js", category: "Frontend", level: "Mid", years: 2, display_order: 11)
react_skill = Skill.create!(name: "React.js", category: "Frontend", level: "Mid", years: 2, display_order: 12)
aws_glue_skill = Skill.create!(name: "AWS Glue", category: "DevOps/Data", level: "Mid", years: 2, display_order: 13)
athena_skill = Skill.create!(name: "AWS Athena", category: "DevOps/Data", level: "Mid", years: 2, display_order: 14)
aws_skill = Skill.create!(name: "AWS", category: "DevOps", level: "Senior", years: 4, display_order: 15)
gcp_skill = Skill.create!(name: "Google Cloud Platform", category: "DevOps", level: "Mid", years: 2, display_order: 16)

puts "Created #{Skill.count} skills."

# 3. Create Experiences
cluvi_exp = Experience.create!(
  company: "Cluvi",
  position: "Ruby Developer",
  employment_type: "full_time",
  start_date: Date.new(2022, 8, 16),
  end_date: Date.new(2026, 6, 25),
  current: false,
  summary: "Desarrollo y mantenimiento de microservicios de la compañía en Ruby on Rails, con participación en proyectos backend en Python y frontend con Angular y Vue.js. Enfoque en calidad del software, mejora de procesos y optimización de rendimiento en servicios críticos.",
  display_order: 1
)

two_tf_exp = Experience.create!(
  company: "2Transfair",
  position: "Ruby Developer",
  employment_type: "full_time",
  start_date: Date.new(2020, 11, 22),
  end_date: Date.new(2022, 8, 05),
  current: false,
  summary: "Lideré el desarrollo de módulos clave para la plataforma e-commerce principal de la compañía, implementando APIs REST rápidas y seguras.",
  display_order: 2
)

puts "Created #{Experience.count} experiences."

# 4. Associate Skills with Experiences
[ rails_skill, ruby_skill, postgres_skill, mongodb_skill, redis_skill, rabbit_queue_skill, sinatra_skill, rspec_skill,
  angular_skill, vue_skill, aws_glue_skill, aws_skill, athena_skill, gcp_skill ].each do |skill|
  ExperienceSkill.create!(experience: cluvi_exp, skill:)
end

[ rails_skill, ruby_skill, postgres_skill, redis_skill, react_skill, aws_skill ].each do |skill|
  ExperienceSkill.create!(experience: two_tf_exp, skill:)
end

puts "Associated skills with experiences."

# 5. Create Achievements
Achievement.create!(
  experience: two_tf_exp,
  title: "Arquitectura serverless en AWS",
  impact: "0 costos fijos",
  description: "Implementé soluciones basadas en AWS Lambda, API Gateway, S3, CloudFront y otros servicios serverless para construir aplicaciones altamente disponibles, escalables y con costos optimizados."
)

Achievement.create!(
  experience: cluvi_exp,
  title: "Diseño de APIs REST escalables",
  impact: "Integración con servicios de terceros",
  description: "Definí contratos de API, versionamiento, manejo de errores, autenticación y buenas prácticas para construir servicios fáciles de mantener y evolucionar."
)

Achievement.create!(
  experience: cluvi_exp,
  title: "Integración con pasarelas de pago",
  impact: "Evité que pasen datos sensibles por el servidor de la empresa",
  description: "Desarrollé servicios para procesamiento de pagos siguiendo buenas prácticas de seguridad utilizando tokenización de tarjetas y/o flujos Web Checkout., abstrayendo las diferencias entre proveedores y facilitando futuras integraciones."
)

Achievement.create!(
  experience: cluvi_exp,
  title: "Optimización de consultas SQL y rendimiento",
  impact: "Mejoré significativamente el rendimiento de aplicaciones identificando cuellos de botella y optimizando consultas a bases de datos.",
  description: "Analicé planes de ejecución, eliminé consultas innecesarias, reduje problemas N+1 e implementé estrategias de optimización para disminuir tiempos de respuesta."
)

Achievement.create!(
  experience: cluvi_exp,
  title: "Optimización del rendimiento de APIs",
  impact: "Reducción de hasta 40% en tiempos de respuesta",
  description: "Migré endpoints construidos con JBuilder hacia JSONAPI::Serializer, disminuyendo el tiempo de generación de respuestas y el consumo de recursos del servidor."
)

Achievement.create!(
  experience: cluvi_exp,
  title: "Fortalecimiento de la calidad del código mediante CI/CD",
  impact: "Reducción del ~70% en errores post-deploy",
  description: "Integré pruebas automatizadas con RSpec y análisis estático mediante herramientas de lint dentro de los pipelines de integración continua, reduciendo la probabilidad de errores en producción."
)

Achievement.create!(
  experience: cluvi_exp,
  title: "Migración tecnológica de microservicios Ruby",
  impact: "Lideré la actualización de aproximadamente 30 microservicios hacia versiones modernas de Ruby, reduciendo deuda técnica y asegurando compatibilidad futura.",
  description: "Planifiqué y ejecuté la migración progresiva de múltiples aplicaciones, resolviendo incompatibilidades entre versiones, actualizando dependencias y garantizando la estabilidad mediante pruebas automatizadas."
)

Achievement.create!(
  experience: cluvi_exp,
  title: "Optimización de costos mediante reducción de consumo de servicios externos",
  impact: "Disminuí costos operativos eliminando llamadas innecesarias a servicios de terceros y resolviendo deuda técnica en componentes críticos.",
  description: "Analicé patrones de consumo, identifiqué oportunidades de optimización e implementé mejoras que redujeron el uso de servicios externos sin afectar la funcionalidad del sistema."
)

Achievement.create!(
  experience: cluvi_exp,
  title: "Diseño de arquitecturas de microservicios",
  impact: "Aumento en resiliencia y escalabilidad atomizada de recursos",
  description: "Trabajé sobre el patrón de microservicios enfocado en separación de responsabilidades y facilitando el escalado horizontal de componentes atomizados"
)

puts "Created achievements."

# 6. Create Projects
serverless_payment_gateway_project = Project.create!(
  experience: two_tf_exp,
  name: "Pasarela de pagos serverless de marca blanca",
  description: "Arquitecturé y desarrollé una pasarela de pagos de marca blanca utilizando Ruby sobre AWS Lambda para el backend y React.js para el frontend. La aplicación fue alojada en Amazon S3, distribuida mediante CloudFront y expuesta a través de API Gateway, logrando una solución escalable, segura y de alta disponibilidad. La arquitectura permitió reutilizar la misma plataforma para diferentes clientes con personalización de marca, acelerando la incorporación de nuevos proyectos y simplificando el mantenimiento.",
  start_date: Date.new(2021, 1, 1),
  end_date: Date.new(2021, 2, 1),
  display_order: 7
)

unit_test_project = Project.create!(
  experience: cluvi_exp,
  name: "Pruebas automatizadas para microservicios existentes",
  description: "Implementación de suites de pruebas unitarias con RSpec en aproximadamente 20 microservicios que carecían de cobertura automatizada, facilitando refactorizaciones seguras y mejorando la calidad de los despliegues.",
  start_date: Date.new(2023, 1, 1),
  end_date: Date.new(2023, 5, 30),
  display_order: 3
)

ruby_migration_project = Project.create!(
  experience: cluvi_exp,
  name: "Migración de microservicios a versiones modernas de Ruby",
  description: "Planificación y ejecución de la migración de aproximadamente 30 microservicios desde Ruby 2.7 hacia versiones más recientes del lenguaje, actualizando dependencias y resolviendo incompatibilidades sin afectar la operación.",
  start_date: Date.new(2026, 2, 1),
  end_date: Date.new(2026, 6, 20),
  display_order: 1
)

rabbit_migration_project =Project.create!(
  experience: cluvi_exp,
  name: "Migración de RabbitMQ Classic a Quorum",
  description: "Migración de todas las colas de RabbitMQ desde Classic Queues hacia Quorum Queues con cero tiempo de inactividad, utilizando una gema interna desarrollada para automatizar y asegurar el proceso.",
  start_date: Date.new(2026, 2, 1),
  end_date: Date.new(2026, 2, 15),
  display_order: 4
)

public_api_project = Project.create!(
  experience: cluvi_exp,
  name: "API pública para integración de servicios",
  description: "Diseño e implementación de una API REST pública que permitió exponer los servicios de la compañía a clientes y aliados mediante autenticación, versionamiento y contratos estandarizados.",
  start_date: Date.new(2025, 1, 1),
  end_date: Date.new(2025, 2, 28),
  display_order: 5
)

tracking_migration_project = Project.create!(
  experience: cluvi_exp,
  name: "Migración del sistema de tracking hacia Google BigQuery",
  description: "Rediseño de la arquitectura de tracking migrando el almacenamiento desde PostgreSQL hacia Google BigQuery. Se reemplazaron procedimientos almacenados por procesos batch, el almacenamiento transaccional por colas RabbitMQ y el procesamiento síncrono por un flujo asíncrono con respuesta inmediata al usuario.",
  start_date: Date.new(2024, 2, 1),
  end_date: Date.new(2024, 7, 31),
  display_order: 6
)

inventory_project = Project.create!(
  experience: cluvi_exp,
  name: "API de sincronización de inventario en tiempo real",
  description: "Desarrollo de un servicio encargado de sincronizar el inventario entre sistemas internos y el menú de la plataforma, garantizando la actualización inmediata de la disponibilidad de productos para los usuarios.",
  start_date: Date.new(2025, 3, 1),
  end_date: Date.new(2025, 4, 1),
  display_order: 10
)

web_scrapers_project = Project.create!(
  experience: cluvi_exp,
  name: "Ingesta automatizada de datos desde sistemas POS",
  description: "Desarrollo de web scrapers capaces de extraer información desde diferentes sistemas POS utilizando formatos TXT, CSV y JSON. Los datos obtenidos eran normalizados y almacenados en Amazon S3 como fuente de datos para posteriores procesos analíticos.",
  start_date: Date.new(2025, 2, 1),
  end_date: Date.new(2025, 12, 30),
  display_order: 8
)

glue_project = Project.create!(
  experience: cluvi_exp,
  name: "Pipeline ETL con AWS Glue",
  description: "Implementación de procesos ETL utilizando AWS Glue para transformar archivos crudos almacenados en Amazon S3 hacia datasets en formato Apache Parquet, optimizando el almacenamiento y el rendimiento de consultas analíticas.",
  start_date: Date.new(2025, 1, 1),
  end_date: Date.new(2025, 12, 31),
  display_order: 9
)

otto_project = Project.create!(
  experience: cluvi_exp,
  name: "Preparación de datos para modelos de Inteligencia Artificial",
  description: "Diseño e implementación de procesos de transformación y enriquecimiento de datos provenientes de múltiples fuentes para generar datasets consistentes y estructurados, utilizados por 'Otto', un asistente basado en inteligencia artificial orientado al sector gastronómico.",
  start_date: Date.new(2025, 1, 1),
  end_date: Date.new(2025, 12, 31),
  display_order: 2
)
puts "Created projects."

# 7. Associate Skills with Projects

[ ruby_skill, postgres_skill, react_skill, aws_skill ].each do |skill|
  ProjectSkill.create!(project: serverless_payment_gateway_project, skill:)
end

[ rails_skill, ruby_skill, postgres_skill, mongodb_skill, redis_skill, rabbit_queue_skill, rspec_skill ].each do |skill|
  ProjectSkill.create!(project: unit_test_project, skill: skill)
end

[ rails_skill, ruby_skill, postgres_skill, mongodb_skill, redis_skill, rabbit_queue_skill, rspec_skill ].each do |skill|
  ProjectSkill.create!(project: ruby_migration_project, skill: skill)
end

[ rails_skill, ruby_skill, rabbit_queue_skill ].each do |skill|
  ProjectSkill.create!(project: rabbit_migration_project, skill: skill)
end

[ rails_skill, ruby_skill, postgres_skill, mongodb_skill, redis_skill, rabbit_queue_skill, rspec_skill ].each do |skill|
  ProjectSkill.create!(project: public_api_project, skill: skill)
end

[ rails_skill, ruby_skill, rabbit_queue_skill, gcp_skill ].each do |skill|
  ProjectSkill.create!(project: tracking_migration_project, skill: skill)
end

[ rails_skill, ruby_skill, postgres_skill, redis_skill, rabbit_queue_skill, rspec_skill ].each do |skill|
  ProjectSkill.create!(project: inventory_project, skill: skill)
end

[ aws_skill, python_skill ].each do |skill|
  ProjectSkill.create!(project: web_scrapers_project, skill: skill)
end

[ aws_skill, python_skill, aws_glue_skill ].each do |skill|
  ProjectSkill.create!(project: glue_project, skill: skill)
end

[ aws_skill, python_skill, aws_glue_skill ].each do |skill|
  ProjectSkill.create!(project: otto_project, skill: skill)
end
puts "Associated skills with projects."
puts "Database successfully seeded!"
