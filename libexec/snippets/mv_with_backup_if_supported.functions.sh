source gnu_backup_option_is_supported_by_command.functions.sh

function mv_with_backup_if_supported() { # arg_supported_by_mv ...

	local mv_candidates=( mv gmv "" )
	local mv
	
	for mv in "${mv_candidates[@]}" ; do

		! gnu_backup_option_is_supported_by_command "$mv" || break
	done

	if [ -n "$mv" ] ; then

		"$mv" --backup --force "$@"{,}
	else
		"${mv_candidates[0]}" "$@"
	fi
}

