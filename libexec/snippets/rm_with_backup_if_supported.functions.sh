function rm_with_backup_if_supported() { # arg_supported_by_both_cp_and_rm ...

	local cp_candidates=( cp gcp "" )
	local cp
	
	for cp in "${cp_candidates[@]}" ; do

		! gnu_backup_option_is_supported_by_command "$cp" || break
	done
	! [ -n "$cp" ] || "$cp" -p --backup --force "$@"{,} 2>&- || :

	rm "$@"
}
