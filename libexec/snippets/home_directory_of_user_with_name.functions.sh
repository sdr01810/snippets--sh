function home_directory_of_user_with_name() { # user_name

	local user_name="${1:?}"

	case "$OSTYPE" in
	darwin*)
		dscacheutil -q user -a name "${user_name:?}" |
			perl -lne 'print if s{^dir:\s+}{}'
	        ;;
	*)
                echo 1>&2 "${FUNCNAME:?}: not supported on this platform"
		false
		;;
	esac
}

