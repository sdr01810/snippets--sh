function package_docker_for_mac_is_not_in_use__probe_using_pgrep() { # [package_root_dpn ...]

	local package_root_dpn_list=( "${@:-/}" )
	local result_p=
	local d1

	list_roots_of_apps_and_data_for_package_docker_for_mac "${package_root_dpn_list[@]}" |
	while read -r d1 ; do

		! pgrep -l -f "^${d1%/}/" || return $?
	done
	#^-- TODO: srogers: use lsof(1) instead of pgrep(1)??
}
