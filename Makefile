STACK_NAME ?= rusty
FUNCTIONS := dynamodb-streams

ARCH := aarch64-unknown-linux-gnu
ARCH_SPLIT = $(subst -, ,$(ARCH))

.PHONY: build deploy tests

setup:
ifeq (,$(shell which rustc))
	$(error "Could not found Rust compiler, please install it")
endif
ifeq (,$(shell which cargo))
	$(error "Could not found Cargo, please install it")
endif
ifeq (,$(shell which zig))
	$(error "Could not found Zig compiler, please install it")
endif
	cargo install cargo-lambda
ifeq (,$(shell which sam))
	$(error "Could not found SAM CLI, please install it")
endif

build:
	cargo lambda build --release --target $(ARCH)

deploy:
	if [ -f samconfig.toml ]; \
		then sam deploy --stack-name $(STACK_NAME); \
		else sam deploy -g --stack-name $(STACK_NAME); \
	fi


