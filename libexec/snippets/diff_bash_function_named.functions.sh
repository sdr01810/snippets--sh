function diff_bash_function_named() { # function_name [option_for_diff ...] bash_script_01_fpn bash_script_02_fpn

	local function_name="${1:?}" ; shift

	local diff_options_quoted=()
	while [ $# -gt 2 ] ; do
		case "${1}" in
		--)
			shift
			break
			;;
		*|'')
			diff_options_quoted+=( "$(qq "${1}")" )
			shift
			;;
		esac
	done

	local bash_script_01_fpn="${1:?}" ; shift
	local bash_script_02_fpn="${1:?}" ; shift

	[ $# -eq 0 ]

	xx :

	##

	local dirs_to_remove=( )
	trap '{
		[ "${#dirs_to_remove[@]}" -eq 0 ] || {

			xx : ;
			xx rm -rf "${dirs_to_remove[@]}" ;
		}
	}' EXIT

	local scratch_dpn="$(mktemp -d -q -t "${this_script_stem:?}.XXXXXX")"
	dirs_to_remove+=( "${scratch_dpn}" )

	##

	mkdir -p "${scratch_dpn:?}"/a
	mkdir -p "${scratch_dpn:?}"/b

	local extracted_function_01_fpn="a/${function_name:?}.bash"
	local extracted_function_02_fpn="b/${function_name:?}.bash"

	##

	(cd "${scratch_dpn:?}" 

		extract_function_from_bash_script "${bash_script_01_fpn:?}" "${function_name:?}" > "${extracted_function_01_fpn:?}"
		extract_function_from_bash_script "${bash_script_02_fpn:?}" "${function_name:?}" > "${extracted_function_02_fpn:?}"

		xx_eval "diff${diff_options_quoted:+ }${diff_options_quoted[@]} $(qq "${extracted_function_01_fpn:?}") $(qq ${extracted_function_02_fpn:?})"
	)
}

