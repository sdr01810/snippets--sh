function ensure_ssh_known_host_entries() { # [ssh_known_host_entry ...]

	local ssh_known_host_entry_list=( "$@" )

	local ssh_known_hosts_fpn="${BDS_HUB_BACKEND_SSH_DATA_DIR:?}/known_hosts"

	local e1

	##

	[ -e "${ssh_known_hosts_fpn:?}" ] || {

		xx :
		xx touch "${ssh_known_hosts_fpn:?}"
		xx chmod 0644 "${ssh_known_hosts_fpn:?}"
	}

	for e1 in "${ssh_known_host_entry_list[@]}" ; do

		[ -n "${e1}" ] || continue

		fgrep -x -q "${e1:?}" "${ssh_known_hosts_fpn:?}" || {

			xx :
			xx append_line_to_file "${ssh_known_hosts_fpn:?}" "${e1:?}"	
		}
	done
}
