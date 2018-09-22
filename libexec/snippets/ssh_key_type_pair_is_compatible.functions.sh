function ssh_key_type_pair_is_compatible() { # value01 value02

	local value01="${1}" ; shift
	local value02="${1}" ; shift

	[ $# -eq 0 ]

	##

	[ -z "${value01}" ] || [ -z "${value02}" ] || [ "${value01}" = "${value02}" ]
}
