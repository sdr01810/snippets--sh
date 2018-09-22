function list_quoted_lsof_args_for_matching_uses_of_package_docker_for_mac() { # [package_root_dpn ...]

	list_roots_of_apps_and_data_for_package_docker_for_mac "$@" |

	while read -r d1 ; do

		[ -d "${d1%/}" ] || continue

		echo +D "$(printf %q "${d1%/}")"
	done
}
