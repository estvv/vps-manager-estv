TARGET_DIR := projects

PROJECT_NAMES := $(notdir $(patsubst %/,%,$(dir $(wildcard $(TARGET_DIR)/*/Makefile))))

COMMANDS := pull up down down-v restart update backup status

INTERACTIVE := logs

CYAN := \033[36m
GREEN := \033[32m
YELLOW := \033[33m
RED := \033[31m
RESET := \033[0m

.PHONY: $(COMMANDS)

$(COMMANDS):
	@echo "Running $(YELLOW)'$@'$(RESET) for all projects."
	@for proj in $(PROJECT_NAMES); do \
		echo "\n----------------------------------------------"; \
		echo "Processing $(YELLOW)'$@'$(RESET) on $(GREEN)$$proj$(RESET)"; \
		$(MAKE) --no-print-directory -C $(TARGET_DIR)/$$proj $@ || echo "$(RED)Failed$(RESET) to execute $(YELLOW)'$@'$(RESET) on $(GREEN)$$proj$(RESET)"; \
		echo "----------------------------------------------\n"; \
	done

define generate_target
$(1)-$(2):
	@echo "Executing $(YELLOW)'$(2)'$(RESET) on $(GREEN)'$(1)'$(RESET)."
	@$$(MAKE) --no-print-directory -C $(TARGET_DIR)/$(1) $(2) || echo "$(RED)Failed$(RESET) to execute $(YELLOW)'$(2)'$(RESET) on $(GREEN)$(1)$(RESET)";
endef

caddy-reload:
	@echo "Reloading $(CYAN)Caddy$(RESET) configuration..."
	@sudo systemctl reload caddy && echo "Caddy reloaded $(GREEN)successfully$(RESET) !" || echo "$(RED)Failed$(RESET) to reload Caddy."

$(foreach proj,$(PROJECT_NAMES),$(foreach cmd,$(COMMANDS) $(INTERACTIVE),$(eval $(call generate_target,$(proj),$(cmd)))))
