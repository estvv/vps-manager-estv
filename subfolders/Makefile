PROJECT_NAME := $(shell basename $(CURDIR))
DATE := $(shell date +%Y-%m-%d)

CYAN := \033[36m
GREEN := \033[32m
YELLOW := \033[33m
RED := \033[31m
RESET := \033[0m

.PHONY: pull up down down-v restart backup update

pull:
	@echo "Pulling latest changes for $(GREEN)$(PROJECT_NAME)$(RESET)..."
	@git pull -q origin main

up:
	@echo "Running $(YELLOW)docker compose up -d$(RESET) for $(GREEN)$(PROJECT_NAME)$(RESET)..."
	docker compose up -d

down:
	@echo "Stopping $(GREEN)$(PROJECT_NAME)$(RESET) with $(YELLOW)docker compose down$(RESET)..."
	docker compose down

down-v:
	@echo "Stopping $(GREEN)$(PROJECT_NAME)$(RESET) and removing volumes with $(YELLOW)docker compose down -v$(RESET)..."
	docker compose down -v

restart:
	@echo "Restarting $(GREEN)$(PROJECT_NAME)$(RESET)..."
	docker compose restart

update: pull
	@echo "Building and restarting $(GREEN)$(PROJECT_NAME)$(RESET) with latest changes..."
	@if [ -f "docker-compose.yml" ] || [ -f "docker-compose.yaml" ]; then \
		docker compose up -d --build --remove-orphans; \
	else \
		echo "No $(YELLOW)docker-compose.yml$(RESET) found, $(RED)skipping Docker step$(RESET)."; \
	fi

backup:
	@echo "Creating backup for $(GREEN)$(PROJECT_NAME)$(RESET)..."
	tar -czf ../backup_$(PROJECT_NAME)_$(DATE).tar.gz \
		--exclude='target' \
		--exclude='node_modules' \
		--exclude='.git' \
		.
	@echo "Backup created: $(CYAN)backup_$(PROJECT_NAME)_$(DATE).tar.gz$(RESET)"

status:
	@echo "Checking status for $(GREEN)$(PROJECT_NAME)$(RESET)..."
	@if [ -f "docker-compose.yml" ] || [ -f "docker-compose.yaml" ]; then \
		docker compose ps; \
	else \
		echo "No $(YELLOW)docker-compose.yml$(RESET) found, $(RED)skipping$(RESET)."; \
	fi

logs:
	@echo "Showing logs for $(GREEN)$(PROJECT_NAME)$(RESET) (Ctrl+C to exit)..."
	@if [ -f "docker-compose.yml" ] || [ -f "docker-compose.yaml" ]; then \
		docker compose logs --tail=50 -f; \
	else \
		echo "No $(YELLOW)docker-compose.yml$(RESET) found, $(RED)skipping$(RESET)."; \
	fi
