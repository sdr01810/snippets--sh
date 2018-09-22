function install_brew_tap() { # [tap_name ...]

	local tap_name_list=( "$@" )
	local x1

	##

	for x1 in "${tap_name_list[@]}" ; do

		xx :
		xx brew tap "${x1}"
	done
}
