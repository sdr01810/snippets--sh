function source_once() { # module_name

	case "${1}" in
	''|[.\ ]*|*[.\ ])
		echo 1>&2 "Invalid module name: '${1}'."
		return 1
		;;
	esac

	# Name of the variable that indicates the source_once state of the specified module.
	#
	# Possible values:
	#
	#     TBD)
	#         source operation has started, but has not yet finished
	#
	#     '')
	#         source operation has not occurred (via source_once)
	#
	#     *)
	#         source operation has finished; value is return code
	#
	local __source_once_module_rc_vn="source_once_module_rc__${1:?}"

	__source_once_module_rc_vn="${__source_once_module_rc_vn%.*sh}"

	__source_once_module_rc_vn="${__source_once_module_rc_vn%.functions}"

	__source_once_module_rc_vn="${__source_once_module_rc_vn//[^_0-9a-zA-Z]/_}"

	if eval "[ \"\${${__source_once_module_rc_vn:?}}\" = TBD ]" ; then

		echo 1>&2 "Cycle detected during source_once; involves: '${__source_once_module_pn:?}'."
		return 1
	fi

	if eval "[ \"\${${__source_once_module_rc_vn:?}}\" != '' ]" ; then

		return 0 # already sourced
	fi

	local __source_once_module_pn_parent_candidates_remaining="${PATH}"

	while [ -n "${__source_once_module_pn_parent_candidates_remaining}" ] ; do

		local __source_once_module_pn_parent="${__source_once_module_pn_parent_candidates_remaining%%:*}"

		__source_once_module_pn_parent_candidates_remaining="${__source_once_module_pn_parent_candidates_remaining#*:}"

		if [ "${__source_once_module_pn_parent}" = "${__source_once_module_pn_parent_candidates_remaining}" ] ; then

			__source_once_module_pn_parent_candidates_remaining=
		fi

		if [ "${__source_once_module_pn_parent}" = '' ] ; then

			continue
		fi

		local __source_once_module_pn="${__source_once_module_pn_parent:?}/${1}".functions.sh

		if [ ! -e "${__source_once_module_pn}" ] ; then

			continue
		fi

		if [ -d "${__source_once_module_pn}" ] ; then

			echo 1>&2 "Module name maps to a directory: '${__source_once_module_pn:?}'."
			return 1
		fi

		eval "${__source_once_module_rc_vn:?}=TBD"

		{
			trap "echo \"Early exit while sourcing file '${__source_once_module_pn:?}'; exit code: \$?.\"" EXIT

			if source "${__source_once_module_pn:?}" ; then

				eval "${__source_once_module_rc_vn:?}=\$?"
			else
				eval "${__source_once_module_rc_vn:?}=\$?"
			fi

			trap '' EXIT
		}

		if eval "[ \"\${${__source_once_module_rc_vn:?}}\" != 0 ]" ; then

			eval "echo 1>&2 \"Error while sourcing file '\${__source_once_module_pn:?}'; returns \${${__source_once_module_rc_vn:?}}.\""
			eval "return \"\${${__source_once_module_rc_vn:?}}\""
		fi

		return 0
	done

	echo 1>&2 "Cannot locate source_once module: '${1}'."
	return 1
}

#^-- FIXME: srogers: provide documentation for function source_once

#^-- FIXME: srogers: implement unit tests for function source_once

