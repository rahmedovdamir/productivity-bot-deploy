# **Max Bot**

## Технологический стек
- **Язык**: Go 1.21+
- **Веб-фреймворк**: Chi
- **База данных**: PostgreSQL 15
- **ORM**: GORM
- **Кэш/Брокер сообщений**: Redis 7
- **Планировщик задач**: robfig/cron
- **Внедрение зависимостей**: Uber Dig
- **Контейнеризация**: Docker & Docker Compose

## *Предварительные требования*
Убедитесь, что у вас установлены следующие инструменты:
- Go версии 1.21 или выше
- Docker и Docker Compose
- (Опционально, для локального запуска) Установленные и запущенные PostgreSQL и Redis

## Установка:

```bash
git clone https://github.com/rahmedovdamir/productivity-bot-deploy.git
```
установленный проект будет иметь структуру:
```
.
├── local
│   ├── docker-compose.yml
│   └── nginx.conf
├── Makefile
├── production
│   ├── docker-compose.yml
│   └── nginx.conf
├── productivity-bot
│   ├── cmd
│   │   └── productivity-bot
│   │       └── main.go
│   ├── Dockerfile
│   ├── go.mod
│   ├── go.sum
│   ├── internal
│   │   ├── config
│   │   │   └── config.go
│   │   ├── db
│   │   │   ├── db.go
│   │   │   └── redis.go
│   │   ├── domain
│   │   │   ├── state.go
│   │   │   ├── tag.go
│   │   │   ├── task.go
│   │   │   └── user.go
│   │   ├── handler
│   │   │   ├── http
│   │   │   │   ├── api_handler
│   │   │   │   │   ├── add_task.go
│   │   │   │   │   ├── delete_task.go
│   │   │   │   │   ├── get_tasks.go
│   │   │   │   │   └── update_task.go
│   │   │   │   ├── contract
│   │   │   │   │   ├── api_tag.go
│   │   │   │   │   └── api_task.go
│   │   │   │   ├── converter
│   │   │   │   │   └── converter.go
│   │   │   │   ├── request
│   │   │   │   │   ├── delete_task.go
│   │   │   │   │   └── get_task.go
│   │   │   │   └── response
│   │   │   │       ├── delete_task.go
│   │   │   │       └── get_tasks.go
│   │   │   └── message_handler.go
│   │   ├── logger
│   │   │   └── logger.go
│   │   ├── repository
│   │   │   ├── tag_repository.go
│   │   │   ├── task_repository.go
│   │   │   └── user_repository.go
│   │   └── service
│   │       ├── notification_service.go
│   │       ├── state_service.go
│   │       ├── tag_service.go
│   │       ├── task_service.go
│   │       └── user_service.go
│   ├── Jenkinsfile
│   ├── Makefile
│   └── productivity-bot
├── productivity-bot-app
│   ├── Dockerfile
│   ├── Jenkinsfile
│   ├── package.json
│   ├── package-lock.json
│   ├── public
│   │   ├── favicon.ico
│   │   ├── index.html
│   │   ├── logo192.png
│   │   ├── logo512.png
│   │   ├── manifest.json
│   │   ├── output.css
│   │   └── robots.txt
│   ├── src
│   │   ├── Api.js
│   │   ├── App.js
│   │   ├── components
│   │   │   ├── CalendarView.js
│   │   │   ├── CategoryHeader.js
│   │   │   ├── Modal.js
│   │   │   ├── modals
│   │   │   │   └── TaskEditorModal.js
│   │   │   ├── NavigationBar.js
│   │   │   ├── NextTasksView.js
│   │   │   ├── ScheduledTasksView.js
│   │   │   ├── SomedayTasksView.js
│   │   │   ├── TaskListView.js
│   │   │   └── TasksView.js
│   │   ├── config.json
│   │   ├── index.css
│   │   ├── index.js
│   │   ├── output.css
│   │   ├── reportWebVitals.js
│   │   └── StorageManager.js
│   └── tailwind.config.js
└── README.md
```
в первую очередь нужно прописать submodule update --init для инициализации сабмодулей (фронт и бек):
productivity-bot-deploy/
```bash
git submodule update —init —recursive
```
Далее в зависимости от того, что вы планируете вы заполянете следующие файлы:

1)Если локальный деплой заполняете следующие файлы:

productivity-bot-deploy/productivity-bot-app/src/config.json
```
{
  "API_BASE_URL": "/api"
}
```

productivity-bot-deploy/productivity-bot/config.json
```
{
  "Env": "local",
  "ApiToken": "f9LHodD0cOJPY8au305gPLTY_bSuHACvqV4h3y7AjfW3dSJWPbeRwLSvilyuMFXuPVXWUDUjvVewy7Z-cE-u",
  "PostgresHost": "db",    
  "PostgresDB": "bot",
  "PostgresUser": "postgres",
  "PostgresPassword": "yourpassword!", 
  "RedisHost": "redis:6379",   
  "RedisDB": 0,
  "HTTPServer": {
    "Address": "0.0.0.0:8081",     
    "Timeout": "4s",
    "IdleTimeout": "60s"
  }
}
```

в папке productivity-bot-deploy/local
создаем папку configs
```bash
mkdir configs
```

productivity-bot-deploy/local/configs/backend-config.json
```
{
  "Env": "local",
  "ApiToken": "f9LHodD0cOJPY8au305gPLTY_bSuHACvqV4h3y7AjfW3dSJWPbeRwLSvilyuMFXuPVXWUDUjvVewy7Z-cE-u",
  "PostgresHost": "db",    
  "PostgresDB": "bot",
  "PostgresUser": "postgres",
  "PostgresPassword": "yourpassword", 
  "RedisHost": "redis:6379",   
  "RedisDB": 0,
  "HTTPServer": {
    "Address": "0.0.0.0:8081",     
    "Timeout": "4s",
    "IdleTimeout": "60s"
  }
}
```

productivity-bot-deploy/local/configs/frontend-config.json
```
{
  "API_BASE_URL": "/api"
}
```
далее прописываете команду в корневой папке
productivity-bot-deploy/
```bash
make local-up
```
проект соберется и запустится

2)Если серверный деплой заполняете следующие файлы:

/productivity-bot-deploy/productivity-bot/config.json
```
{
  "Env" : "prod",
  "ApiToken":"f9LHodD0cOJPY8au305gPLTY_bSuHACvqV4h3y7AjfW3dSJWPbeRwLSvilyuMFXuPVXWUDUjvVewy7Z-cE-u",
  "PostgresHost": "db",
  "PostgresDB": "bot",
  "PostgresUser": "postgres",
  "PostgresPassword": "123",
  "RedisHost": "redis:6379",
  "RedisDB": 0,
  "HTTPServer": {
    "Address": "0.0.0.0:8081",
    "Timeout": "4s",
    "IdleTimeout": "60s"
  }
}
```

/productivity-bot-deploy/productivity-bot-app/src/config.json
```
{
    "API_BASE_URL": "https://81.177.140.170/api"
}
```

в папке ~/productivity-bot-deploy/production
создаем папку configs
```bash
mkdir configs
```

/productivity-bot-deploy/production/configs/backend-config.json 
```
{
  "Env" : "prod",
  "ApiToken":"f9LHodD0cOJPY8au305gPLTY_bSuHACvqV4h3y7AjfW3dSJWPbeRwLSvilyuMFXuPVXWUDUjvVewy7Z-cE-u",
  "PostgresHost": "db",
  "PostgresDB": "bot",
  "PostgresUser": "postgres",
  "PostgresPassword": "123",
  "RedisHost": "redis:6379",
  "RedisDB": 0,
  "HTTPServer": {
    "Address": "0.0.0.0:8081",
    "Timeout": "4s",
    "IdleTimeout": "60s"
  }
}
```

/productivity-bot-deploy/production/configs/frontend-config.json 
```
{
    "API_BASE_URL": "https://81.177.140.170/api"
}
```

далее в папке ~/productivity-bot-deploy/production
создаем  папку ssl
```bash
mkdir ssl
```
и импортируйте туда свои ssl ключи:    
```
  domain.crt
  domain.csr  
  domain.key
  password
```

далее в корневой папке 
~/productivity-bot-deploy
прописываете 
```bash
make prod-up
```
проект соберется и запустится

Затестировать можете в приложении MAX!

после создания файлов у вас должна получиться следующая структура:
```
.
├── local
│   ├── configs
│   │   ├── backend-config.json
│   │   └── frontend-config.json
│   ├── docker-compose.yml
│   └── nginx.conf
├── Makefile
├── production
│   ├── configs
│   │   ├── backend-config.json
│   │   └── frontend-config.json
│   ├── docker-compose.yml
│   ├── nginx.conf
│   └── ssl
│       ├── domain.crt
│       ├── domain.csr
│       ├── domain.key
│       ├── nginx.conf
│       └── password
├── productivity-bot
│   ├── cmd
│   │   └── productivity-bot
│   │       └── main.go
│   ├── config.json
│   ├── Dockerfile
│   ├── go.mod
│   ├── go.sum
│   ├── internal
│   │   ├── config
│   │   │   └── config.go
│   │   ├── db
│   │   │   ├── db.go
│   │   │   └── redis.go
│   │   ├── domain
│   │   │   ├── state.go
│   │   │   ├── tag.go
│   │   │   ├── task.go
│   │   │   └── user.go
│   │   ├── handler
│   │   │   ├── http
│   │   │   │   ├── api_handler
│   │   │   │   │   ├── add_task.go
│   │   │   │   │   ├── delete_task.go
│   │   │   │   │   ├── get_tasks.go
│   │   │   │   │   └── update_task.go
│   │   │   │   ├── contract
│   │   │   │   │   ├── api_tag.go
│   │   │   │   │   └── api_task.go
│   │   │   │   ├── converter
│   │   │   │   │   └── converter.go
│   │   │   │   ├── request
│   │   │   │   │   ├── delete_task.go
│   │   │   │   │   └── get_task.go
│   │   │   │   └── response
│   │   │   │       ├── delete_task.go
│   │   │   │       └── get_tasks.go
│   │   │   └── message_handler.go
│   │   ├── logger
│   │   │   └── logger.go
│   │   ├── repository
│   │   │   ├── tag_repository.go
│   │   │   ├── task_repository.go
│   │   │   └── user_repository.go
│   │   └── service
│   │       ├── notification_service.go
│   │       ├── state_service.go
│   │       ├── tag_service.go
│   │       ├── task_service.go
│   │       └── user_service.go
│   ├── Jenkinsfile
│   ├── Makefile
│   └── productivity-bot
├── productivity-bot-app
│   ├── Dockerfile
│   ├── Jenkinsfile
│   ├── package.json
│   ├── package-lock.json
│   ├── public
│   │   ├── favicon.ico
│   │   ├── index.html
│   │   ├── logo192.png
│   │   ├── logo512.png
│   │   ├── manifest.json
│   │   ├── output.css
│   │   └── robots.txt
│   ├── src
│   │   ├── Api.js
│   │   ├── App.js
│   │   ├── components
│   │   │   ├── CalendarView.js
│   │   │   ├── CategoryHeader.js
│   │   │   ├── Modal.js
│   │   │   ├── modals
│   │   │   │   └── TaskEditorModal.js
│   │   │   ├── NavigationBar.js
│   │   │   ├── NextTasksView.js
│   │   │   ├── ScheduledTasksView.js
│   │   │   ├── SomedayTasksView.js
│   │   │   ├── TaskListView.js
│   │   │   └── TasksView.js
│   │   ├── config.json
│   │   ├── index.css
│   │   ├── index.js
│   │   ├── output.css
│   │   ├── reportWebVitals.js
│   │   └── StorageManager.js
│   └── tailwind.config.js
└── README.md
```





