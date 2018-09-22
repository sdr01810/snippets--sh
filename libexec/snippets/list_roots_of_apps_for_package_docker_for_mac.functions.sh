function list_roots_of_apps_for_package_docker_for_mac() { # [package_root_dpn ...]

	local package_root_dpn_list=( "${@:?}" )
	local d1

	for d1 in "${package_root_dpn_list[@]}" ; do

		ls -d "${d1%/}"/Applications/Docker.app 2>&- || :
	done
}
