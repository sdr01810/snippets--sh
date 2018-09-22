function check_package_brew_installation_root() { # installation_root_dpn

	local installation_root_dpn="${1:?}" ; shift

	[ $# -eq 0 ]

	##

	case "${installation_root_dpn:?}" in
	/*)
		true
		;;
	*)
		echo 1>&2 "Must be absolute (not relative) path: ${installation_root_dpn:?}"
		(false ; return)
		;;
	esac

	! [ -L "${installation_root_dpn:?}" ] || { 

		echo 1>&2 "Must be directory (not symbolic link): ${installation_root_dpn:?}"
		(false ; return)
	}

	[ -d "${installation_root_dpn:?}" ] || {

		echo 1>&2 "Must be directory (created already): ${installation_root_dpn:?}"
		(false ; return)
	}
}
