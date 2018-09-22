function extract_functions_from_bash_script_into_directory() { # [--force] destination_dpn bash_script_fpn ...

	local force_p=

	while [ $# -gt 0 ] ; do
		case "${1}" in
		--force)
			force_p=t
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

	local destination_dpn="${1:?}" ; shift

	local bash_script_fpn_list=( "$@" ) ; shift $#

	[ ${#bash_script_fpn_list[@]} -gt 0 ]

	[ $# -eq 0 ]

	##

	for f1 in "${bash_script_fpn_list[@]}" ; do

		cat "$f1" | perl -lne 'print if s{^\s*(?:function\s)?\s*([-\w]+)\s*\(\).*} {$1}' |

		egrep -v '^(main)$' |

		while read -r function_name ; do

			f2="${destination_dpn%/}/${function_name:?}.functions.sh"

			! [ -e "${f2}" ] || ! [ -z "${force_p}" ] || continue

			xx :
			xx extract_function_from_bash_script "${f1}" "${function_name:?}" > "${f2}"
		done
	done
}
