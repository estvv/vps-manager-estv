SHELL := /bin/bash

TARGET_DIR=projects

PROJECT_NAME := $(notdir $(patsubst %/,%,$(dir $(wildcard $(TARGET_DIR)/*/Makefile))))

DATE := $(shell date +%Y-%m-%d)

CYAN := \033[36m
GREEN := \033[32m
YELLOW := \033[33m
RED := \033[31m
RESET := \033[0m

.PHONY: pull up down down-v restart backup update

all: pull up

pull:
	@echo -e "Pulling latest changes for $(GREEN)$(PROJECT_NAME)$(RESET)..."
	git pull -q origin main

up:
	@echo -e "Running $(YELLOW)docker compose up -d$(RESET) for $(GREEN)$(PROJECT_NAME)$(RESET)..."
	docker compose up -d

down:
	@echo -e "Stopping $(GREEN)$(PROJECT_NAME)$(RESET) with $(YELLOW)docker compose down$(RESET)..."
	docker compose down

down-v:
	@echo -e "Stopping $(GREEN)$(PROJECT_NAME)$(RESET) and removing volumes with $(YELLOW)docker compose down -v$(RESET)..."
	docker compose down -v

restart:
	@echo -e "Restarting $(GREEN)$(PROJECT_NAME)$(RESET)..."
	docker compose restart

update: pull
	@echo -e "Building and restarting $(GREEN)$(PROJECT_NAME)$(RESET) with latest changes..."
	docker compose up -d --build --remove-orphans

backup:
	@echo -e "Creating backup for $(GREEN)$(PROJECT_NAME)$(RESET)..."
	tar -czf ../backup_$(PROJECT_NAME)_$(DATE).tar.gz \
		--exclude='target' \
		--exclude='node_modules' \
		--exclude='.git' \
		.
	@echo -e "Backup created: $(CYAN)backup_$(PROJECT_NAME)_$(DATE).tar.gz$(RESET)"
