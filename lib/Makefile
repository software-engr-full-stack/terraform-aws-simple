# Some declarations are not used here but used in calling Makefiles.

.PHONY: init plan apply destroy

_mkfile_path := $(realpath $(lastword $(MAKEFILE_LIST)))
_app_dir := $(abspath $(dir $(_mkfile_path))..)

_user_file_dest := tmp_file_user.tf

define check_empty_string
	@if [ -z "$(1)" ]; then \
		echo '... ERROR: a needed argument is not given' >&2; \
		exit 1; \
	fi
endef

define check_file_exists
	@if [ ! -f "$(1)" ]; then \
		echo "... ERROR: file '$(1)' doesn't exist" >&2; \
		exit 1; \
	fi
endef

define init
	$(call check_empty_string,$(1))
	$(call check_file_exists,$(1))

	cp "$(1)" "$(_user_file_dest)" && \
		terraform init || :
	rm "$(_user_file_dest)"
endef
