function ensure_package_docker_for_mac_is_not_in_use() { # [package_root_dpn ...]

	! package_docker_for_mac_is_in_use "$@" || {

		echo 1>&2
		echo 1>&2 "Looks like Docker for Mac is currently in use ..."

		wait_interactively_until_package_docker_for_mac_is_not_in_use "$@" || {

			echo 1>&2 "^-- aborting"
			false
		}
	}
}
