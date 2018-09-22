function backup_package_brew_installation_root_to() { # backup_destination_fpn installation_root_dpn

	local backup_destination_fpn="${1:?}" ; shift
	local installation_root_dpn="${1:?}" ; shift

	[ $# -eq 0 ]

	##

	local backup_destination_fpn_exclusion_pattern="${backup_destination_fpn#${installation_root_dpn%/}/}"

	(cd "${installation_root_dpn:?}"

		xx :
		xx sudo tar czf "${backup_destination_fpn:?}" --exclude "${backup_destination_fpn_exclusion_pattern:?}" .
	)
}
