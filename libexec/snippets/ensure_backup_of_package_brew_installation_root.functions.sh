function ensure_backup_of_package_brew_installation_root() { # installation_root_dpn backup_destination_fpn

	local installation_root_dpn="${1:?}" ; shift
	local backup_destination_fpn="${1:?}" ; shift


	[ $# -eq 0 ]

	##

	[ -s "${backup_destination_fpn:?}" ] || 
	backup_package_brew_installation_root_to "${backup_destination_fpn:?}" "${installation_root_dpn:?}"
}
