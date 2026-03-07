# День 3: Docker Compose и реальное приложение

## Что изучил

✅ Написал docker-compose.yml для multi-контейнерного приложения  
✅ Подключи Flask приложение к PostgreSQL  
✅ Настроил volumes для persistence данных  
✅ Изучил Docker networks  
✅ Научился управлять стеком сервисов  

## Архитектура приложения
┌─────────────┐ ┌──────────────┐
│ Flask │────▶│ PostgreSQL │
│ App │ │ Database │
│ (port 5000)│ │ (port 5432) │
└─────────────┘ └──────────────┘
│ │
└──────network────────┘
│
└─volumes─┘
(postgres_data)

## docker-compose.yml

```yaml
version: '3.8'

services:
  app:
    build: .
    ports:
      - "5000:5000"
    environment:
      - DB_HOST=db
      - DB_NAME=appdb
      - DB_USER=user
      - DB_PASSWORD=password
    depends_on:
      - db
    networks:
      - backend

  db:
    image: postgres:15-alpine
    environment:
      - POSTGRES_DB=appdb
      - POSTGRES_USER=user
      - POSTGRES_PASSWORD=password
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
    networks:
      - backend

volumes:
  postgres_data:

networks:
  backend:
    driver: bridge
```
### Собрать и запустить все сервисы
`docker-compose up --build -d`

### Проверить статус
`docker-compose ps`

### Посмотреть логи
`docker-compose logs -f`

### Проверить подключение к БД
`curl http://localhost:5000/db-test`
### Output: {"status":"DB Connected!"}

### Зайти в контейнер БД
`docker-compose exec db psql -U user -d appdb`

### Создать тестовую таблицу
`CREATE TABLE users (id SERIAL PRIMARY KEY, name VARCHAR(100));`
`INSERT INTO users (name) VALUES ('Max'), ('Sergey'), ('Anna');`
`SELECT * FROM users;`

### Выйти
`\q`

### Останови сервисы (данные сохранятся!)
`docker-compose down`

### Запусти снова
`docker-compose up -d`

### Проверить что данные на месте
`docker-compose exec db psql -U user -d appdb -c "SELECT * FROM users;"`

### Удалить всё включая volumes
`docker-compose down -v`