function find_docker_data() { # usage same as find(1), plus: [-aggressive] [-conservative]

	local quoted_starting_points=()
	while [ $# -gt 0 ] ; do

		case "${1}" in
		-*)
			break
			;;
		*|'')
			quoted_starting_points+=( "$(qq "${1}")" )
			shift
			;;
		esac
	done
	if [ "${#quoted_starting_points[@]}" -eq 0 ] ; then

		case "${OSTYPE}" in
		cygwin|msys)
			true # TODO: add support for {Cygwin,MSys,Windows}
			;;
		darwin*)
			quoted_starting_points=(

				"$(qq "/Library")"
				"$(qq "/System/Library")"
				"$(qq "${HOME:?}"/Library)"
			)
			;;
		*)
			true # TODO: add support for Unix
			;;
		esac
	fi
	if [ "${#quoted_starting_points[@]}" -eq 0 ] ; then

		echo 1>&2 "Missing argument(s): starting point(s)"
		return 1
	fi

	local heuristics_options=()
	local quoted_expression_tail=()
	while [ $# -gt 0 ] ; do

		case "${1}" in
		-aggressive|-conservative)
			heuristics_options+=( "${1}" )
			shift
			;;	
		*|'')
			quoted_expression_tail+=( "$(qq "${1}")" )
			shift
			;;	
		esac
	done

	xx :
	xx_eval "find ${quoted_starting_points[@]} $(
		echo_quoted_find_expression_that_matches_docker_data "${heuristics_options[@]}") ${quoted_expression_tail[@]}"
}

