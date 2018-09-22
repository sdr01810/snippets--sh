function infer_ssh_key_type_from_file_name_but_not_contents() { # ssh_key_fpn

	local ssh_key_fpn="${1:?}" ; shift

	[ $# -eq 0 ]

	##

	local ssh_key_fbn="$(basename "${ssh_key_fpn:?}")"

	local ssh_key_type_indicator="$(echo "${ssh_key_fbn:?}" | sed -e 's/[^a-zA-Z0-9_].*$//')"

	local result=
	case "${ssh_key_type_indicator}" in
	id_*)
		result="${ssh_key_type_indicator#id_}"
		;;
	esac
	echo "${result}"
	[ -n "${result}" ]
}
