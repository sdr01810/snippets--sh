function remove_listed_files_and_dirs() { # [option_for_rm ...]

	local x1

	while read -r x1 ; do

		rm -rf "$@" "${x1}"
	done
}
