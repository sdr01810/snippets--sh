function check_directory_exists() { # directory_pn ensure_p

	local directory_pn="${1:?}"
	local ensure_p="${2}"

	if [ ! -e "${directory_pn:?}" ] ; then

		if [ -n "${ensure_p}" ] ; then

			mkdir -p "${directory_pn:?}"
			return $?
		else
			echo 1>&2 "Directory does not exist: ${directory_pn:?}"
			return 2
		fi
	fi

	if [ ! -d "${directory_pn:?}" ] ; then

		echo 1>&2 "Not a directory: ${directory_pn}"
		return 2
	fi

	return 0
}
