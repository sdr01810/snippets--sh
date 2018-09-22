function remove_package_docker_for_mac() { # [:globally | user_name]

	local user_spec="${1:-:globally}"

        local package_root_dpn_list=()
	case "${user_spec}" in
	:globally)
		package_root_dpn_list=( "/" "$(home_directory_of_user_with_name "$(id -un)")" )
		;;
	*)
		package_root_dpn_list=( "$(home_directory_of_user_with_name "${user_spec:?}")" )
		;;
	esac

	ensure_package_docker_for_mac_is_not_in_use "${package_root_dpn_list[@]}"

	remove_apps_for_package_docker_for_mac "${package_root_dpn_list[@]}"

	remove_data_for_package_docker_for_mac "${package_root_dpn_list[@]}"

	#^-- FIXME: srogers: add support for keeping data
}
