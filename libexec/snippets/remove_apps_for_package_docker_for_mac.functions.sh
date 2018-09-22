function remove_apps_for_package_docker_for_mac() { # [package_root_dpn ...]

	local package_root_dpn_list=( "${@:-/}" )
	local d1

	list_roots_of_apps_for_package_docker_for_mac "${package_root_dpn_list[@]}" |
	while read -r d1 ; do

		[ -d "${d1%/}" ] || continue

		xx :
		xx "${d1%/}/Contents/MacOS/Docker" --uninstall

		xx :
		xx rm -rf "$d1"
	done
}
