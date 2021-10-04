ifneq ($(MAKECMDGOALS),init)
ifndef VARS_FILE
$(error VARS_FILE is not set)
endif
endif

INIT_COMMAND="packer init ."
VALIDATE_COMMAND="packer validate --var-file=$(VARS_FILE) ."
BUILD_COMMAND="packer build --var-file=$(VARS_FILE) ."

init:
	eval $(INIT_COMMAND)

validate:
	eval $(VALIDATE_COMMAND)

build:
	eval $(BUILD_COMMAND)