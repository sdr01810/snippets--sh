function wait_interactively_until_package_docker_for_mac_is_not_in_use()  { # [package_root_dpn ...]

	local quoted_lsof_args_for_matching_uses_of_interest=(
		$(list_quoted_lsof_args_for_matching_uses_of_package_docker_for_mac "$@")
	)

	! [ "${#quoted_lsof_args_for_matching_uses_of_interest[@]}" -eq 0 ] || return 0

	[ -t 1 ] # interactively ...

	xx :
	xx : "Waiting until Docker for Mac is not in use (you handle it) ..."
	xx :
	xx eval "lsof +r" "${quoted_lsof_args_for_matching_uses_of_interest[@]}" || (echo 1>&2 && false)
}
