function define_return_codes_for_ensure_ssh_key() { #

	cat <<-EOF
	ensure_ssh_key_rc_already_existed_and_add_succeeded=0
	ensure_ssh_key_rc_already_existed_and_add_failed=1
	ensure_ssh_key_rc_auto_generate_succeeded=2
	ensure_ssh_key_rc_auto_generate_failed=3
	ensure_ssh_key_rc_internal_error=4
	EOF
}
