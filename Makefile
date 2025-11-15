<<<<<<< HEAD
.PHONY: help local-up local-down prod-up prod-down build logs clean update restart restart-prod build-backend build-backend-local build-backend-prod

help:
	@echo "Available commands:"
	@echo "  update              - Update git submodules"
	@echo "  local-up            - Start local environment"
	@echo "  local-down          - Stop local environment" 
	@echo "  local-logs          - Show local logs"
	@echo "  prod-up             - Start production environment"
	@echo "  prod-down           - Stop production environment"
	@echo "  prod-logs           - Show production logs"
	@echo "  build-local         - Build local images"
	@echo "  build-prod          - Build production images"
	@echo "  build               - Build all images"
	@echo "  build-backend       - Build backend Docker image (production by default)"
	@echo "  build-backend-local - Build backend Docker image for local"
	@echo "  build-backend-prod  - Build backend Docker image for production"
	@echo "  clean               - Stop all and clean up"
	@echo "  restart             - Restart local environment"
	@echo "  restart-prod        - Restart production environment"


update:
	git submodule update --init --recursive

local-up: update build-backend-local
	docker-compose -f local/docker-compose.yml up -d

local-down:
	docker-compose -f local/docker-compose.yml down

local-logs:
	docker-compose -f local/docker-compose.yml logs -f

prod-up: update build-backend-prod
	docker-compose -f production/docker-compose.yml up -d

prod-down:
	docker-compose -f production/docker-compose.yml down

prod-logs:
	docker-compose -f production/docker-compose.yml logs -f

build-local: update build-backend-local
	docker-compose -f local/docker-compose.yml build

build-prod: update build-backend-prod
	docker-compose -f production/docker-compose.yml build

build-backend-local:
	@echo "Building backend Docker image for LOCAL environment..."
	docker build --build-arg ENV=local --no-cache --progress=plain -t backend-local -f productivity-bot/Dockerfile .

build-backend-prod:
	@echo "Building backend Docker image for PRODUCTION environment..."
	docker build --build-arg ENV=production --no-cache --progress=plain -t backend-prod -f productivity-bot/Dockerfile .


build-backend: build-backend-prod

build: build-local build-prod

clean: local-down prod-down
	docker system prune -f

restart: local-down local-up
	@echo "Local environment restarted"

restart-prod: prod-down prod-up
	@echo "Production environment restarted"
