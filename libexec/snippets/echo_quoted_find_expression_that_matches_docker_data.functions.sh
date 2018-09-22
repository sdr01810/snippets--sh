function echo_quoted_find_expression_that_matches_docker_data() { # [-aggressive] [-conservative]

	local use_aggressive_heuristics_p=
	local use_conservative_heuristics_p=
	
	while [ $# -gt 0 ] ; do

		case "${1}" in
		-aggressive)
			use_aggressive_heuristics_p=t
			use_conservative_heuristics_p=
			shift
			;;
	
		-conservative)
			use_aggressive_heuristics_p=
			use_conservative_heuristics_p=t
			shift
			;;
		--)
			shift
			break
			;;
		*)
			break
			;;
		esac
	done
	
	[ $# -eq 0 ]

	##
	
	local result=

	case "${OSTYPE}" in
	cygwin|msys)
		true # TODO: add support for {Cygwin,MSys,Windows}
		;;
	darwin*)
		if [ -n "${use_aggressive_heuristics_p}" ] ; then

			result="$(qq "(") -name $(qq "com.docker.*") -o -name $(qq "*.com.docker.*") $(qq ")")"
		else
			result="$(qq "(") -name $(qq "com.docker.*") -o -name $(qq "group.com.docker.*") $(qq ")")"
		fi
		;;
	*)
		true # TODO: add support for Unix
		;;
	esac
	echo "${result:?}"
}

