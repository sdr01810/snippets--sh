function resolved_pathname__recursive() { # have_realpath_p value

	local have_realpath_p="${1}" ; shift
	local value="${1:?}" ; shift
	local result

	[ $# -eq 0 ]

	##
	
	if [ -n "${have_realpath_p}" ] && [ -e "${value:?}" ] ; then

		realpath "${value:?}"
	else
	if [ -d "${value:?}" ] ; then

		(cd "${value:?}" && pwd -P)
	else
		local value_parent_dpn_resolved="$(resolved_pathname__recursive "${have_realpath_p}" "$(dirname "${value:?}")")"

		echo "${value_parent_dpn_resolved:?}/$(basename "${value:?}")"
	fi;fi
}

