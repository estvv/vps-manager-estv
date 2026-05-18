TARGET_DIR := projects

PROJECT_NAMES := $(notdir $(patsubst %/,%,$(dir $(wildcard $(TARGET_DIR)/*/Makefile))))

COMMANDS := pull up down down-v restart update backup

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
	@$$(MAKE) -C $(TARGET_DIR)/$(1) $(2)
endef

$(foreach proj,$(PROJECT_NAMES),$(foreach cmd,$(COMMANDS),$(eval $(call generate_target,$(proj),$(cmd)))))
