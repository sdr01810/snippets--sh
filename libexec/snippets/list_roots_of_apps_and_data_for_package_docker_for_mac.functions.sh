function list_roots_of_apps_and_data_for_package_docker_for_mac() { # [package_root_dpn ...]

	list_roots_of_apps_for_package_docker_for_mac "${@}"

	list_roots_of_data_for_package_docker_for_mac "${@}"
}
