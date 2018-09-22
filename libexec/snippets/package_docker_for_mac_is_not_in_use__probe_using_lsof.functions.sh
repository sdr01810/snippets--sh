function package_docker_for_mac_is_not_in_use__probe_using_lsof() { # [package_root_dpn ...]

	local quoted_lsof_args_for_matching_uses_of_interest=(
		$(list_quoted_lsof_args_for_matching_uses_of_package_docker_for_mac "$@")
	)

	! [ "${#quoted_lsof_args_for_matching_uses_of_interest[@]}" -eq 0 ] || return 0

	! eval "lsof" "${quoted_lsof_args_for_matching_uses_of_interest[@]}" || return $?
}
