function download_package_brew_installation_script_to() { # script_destination_fpn script_url

	local script_destination_fpn="${1:?}" ; shift
	local script_url="${1:?}" ; shift

	[ $# -eq 0 ]

	##

	xx :
	xx curl -fsSL "${script_url:?}" > "${script_destination_fpn:?}"
}
