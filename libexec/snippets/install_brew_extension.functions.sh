function install_brew_extension() { # [extension_name ...]

	local extension_name_list=( "$@" )
	local x1

	##

	for x1 in "${extension_name_list[@]}" ; do

		xx :
		xx without_output brew "${x1}" --help
		xx : "^-- side effect: installs extension '${x1}'"
	done
}
