include ../../../lib/Makefile

_tf_backend_src := $(_app_dir)/user/backends/long-term_eip.tf
_tf_args := -var-file=$(_app_dir)/config/vars.json \
	          -var-file=$(_app_dir)/config/eip.json

init:
	$(call init,$(_tf_backend_src))

plan:
	$(call plan,$(_tf_backend_src))

apply:
	$(call _apply_or_destroy,$(_tf_backend_src), apply)

destroy:
	$(call _apply_or_destroy,$(_tf_backend_src), destroy)

define plan
	$(call check_empty_string,$(1))
	$(call check_file_exists,$(1))

	cp "$(1)" "$(_user_file_dest)" && \
		terraform plan $(_tf_args) || :
	rm "$(_user_file_dest)"
endef

define _apply_or_destroy
	$(call check_empty_string,$(1))
	$(call check_file_exists,$(1))

	cp "$(1)" "$(_user_file_dest)" && \
		if [ -n "$(approve)" ]; then \
			terraform $(2) -auto-approve $(_tf_args); \
		else \
			terraform $(2) $(_tf_args); \
		fi || :
	rm "$(_user_file_dest)"
endef
