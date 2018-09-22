function check_file_exists() { # file_pn ensure_p

	local file_pn="${1:?}"
	local ensure_p="${2}"

	if [ ! -e "${file_pn:?}" ] ; then

		if [ -n "${ensure_p}" ] ; then

			check_directory_exists "$(dirname "${file_pn:?}")" :ensure

			touch "${file_pn:?}"
			return $?
		else
			echo 1>&2 "File does not exist: ${file_pn:?}"
			return 2
		fi
	fi

	if [ ! -f "${file_pn:?}" ] ; then

		echo 1>&2 "Not a file: ${file_pn}"
		return 2
	fi

	return 0
}
