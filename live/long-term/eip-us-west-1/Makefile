include ../../../lib/Makefile

_tf_backend_src := $(_app_dir)/user/backends/permanent_eip_us-west-1.tf
_eip_var_file  := $(_app_dir)/config/eip_us-west-1.json

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
		terraform plan -var-file=$(_eip_var_file) || :
	rm "$(_user_file_dest)"
endef

define _apply_or_destroy
	$(call check_empty_string,$(1))
	$(call check_file_exists,$(1))

	cp "$(1)" "$(_user_file_dest)" && \
		if [ -n "$(approve)" ]; then \
			terraform $(2) -auto-approve -var-file=$(_eip_var_file); \
		else \
			terraform $(2) -var-file=$(_eip_var_file); \
		fi || :
	rm "$(_user_file_dest)"
endef
