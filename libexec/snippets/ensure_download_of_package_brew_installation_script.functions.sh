function ensure_download_of_package_brew_installation_script() { # script_destination_fpn script_url

	local script_destination_fpn="${1:?}" ; shift
	local script_url="${1:?}" ; shift

	[ $# -eq 0 ]

	##

	! [ -n "${BREW_BOOTSTRAP_POLICY_ALWAYS_DOWNLOAD_PACKAGE_BREW_INSTALLATION_SCRIPTS}" ] || {

		> "${script_destination_fpn:?}"
	}

	[ -s "${script_destination_fpn:?}" ] || {

		download_package_brew_installation_script_to "${script_destination_fpn:?}" "${script_url:?}"

		xx :
		xx chmod a+rx "${script_destination_fpn:?}"
	}
}
