# Portfolio API

Backend API para la aplicación de Portfolio, construida sobre Ruby on Rails.

## Stack Técnico

- **Lenguaje:** Ruby 4.0.5
- **Framework:** Rails ~> 8.1.3 (modo API)
- **Base de Datos:** PostgreSQL (~> 1.1)
- **Servidor Web:** Puma
- **Serialización JSON:** Alba (`alba`) "Elegí Alba como serializador debido a su rendimiento superior frente a alternativas tradicionales como Jbuilder o ActiveModelSerializers
- **Manejador de Tareas:** Solid Queue
- **Caché:** Solid Cache
- **Pub/Sub (WebSockets):** Solid Cable
- **Pruebas:** RSpec (con `rspec-rails`)
- **Calidad de Código y Estilo:** RuboCop (configuración Omakase `rubocop-rails-omakase`)
- **Seguridad:** Brakeman (análisis estático) y Bundler Audit (auditoría de gemas)
- **Despliegue:** Kamal (contenedorizado con Docker y Thruster)

## Configuración y Setup Local

### Prerrequisitos

Asegúrate de tener instalado en tu máquina local:
- Ruby `4.0.5`
- PostgreSQL corriendo localmente o en un contenedor (puerto `5432` por defecto)

### Pasos para iniciar el proyecto

1. **Clonar el repositorio:**
   ```bash
   git clone <url-del-repositorio>
   cd portfolio-api
   ```

2. **Configurar variables de entorno:**
   Copia el archivo de plantilla `.env.example` a `.env` y edita los valores con las credenciales de tu base de datos local:
   ```bash
   cp .env.example .env
   ```

3. **Instalar dependencias:**
   ```bash
   bundle install
   ```

4. **Preparar la base de datos:**
   ```bash
   bin/rails db:prepare
   ```

5. **Iniciar el servidor de desarrollo:**
   Puedes iniciar el servidor de desarrollo utilizando:
   ```bash
   bin/dev
   ```
   O utilizando el proxy Thruster si deseas simular el entorno de producción localmente:
   ```bash
   ./bin/thrust ./bin/rails server
   ```

## Pruebas y Calidad de Código

### Ejecución de Pruebas (RSpec)

Para ejecutar la suite de pruebas:
```bash
bundle exec rspec
```

### Script de Integración Continua (CI) Local

Puedes ejecutar toda la suite de validación local (incluyendo linters, auditorías de seguridad y pruebas) usando el script unificado de integración continua:
```bash
bin/ci
```

### Linters y Análisis Estático

Para comprobar el estilo del código y auto-corregir problemas menores de formato con RuboCop:
```bash
bundle exec rubocop
# Para corrección automática:
bundle exec rubocop -A
```

Para análisis de seguridad estático (Brakeman):
```bash
bin/brakeman
```

Para auditar gemas con vulnerabilidades conocidas:
```bash
bin/bundler-audit
```
