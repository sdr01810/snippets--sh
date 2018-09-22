source gnu_backup_option_is_supported_by_command.functions.sh

function cp_with_backup_if_supported() { # arg_supported_by_cp ...

	local cp_candidates=( cp gcp "" )
	local cp
	
	for cp in "${cp_candidates[@]}" ; do

		! gnu_backup_option_is_supported_by_command "$cp" || break
	done

	if [ -n "$cp" ] ; then

		"$cp" -p --backup --force "$@"{,}
	else
		"${cp_candidates[0]}" "$@"
	fi
}

