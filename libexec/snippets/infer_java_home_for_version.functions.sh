function infer_java_home_for_version() { # version_spec

	local version_spec="${1:?}" ; shift

	[ $# -eq 0 ]

	##

	local result=

	case "${OSTYPE}" in
	darwin*)
		hash /usr/libexec/java_home 2>&- || return 1 # fail

		result="$(/usr/libexec/java_home -version "${version_spec:?}" 2>&-)" || return 1 # fail

		#^-- NB: java_home honors JAVA_VERSION and JAVA_ARCH; see also java_home(1).
		;;
	*)
		# FIXME: sdr01810: add support for Un*x platforms

		return 1 # fail
		;;
	esac
	echo "${result}"
}
