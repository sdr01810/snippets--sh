function install_brew_bundle() { # [bundle_name ...]

	local bundle_name_list=( "$@" )
	local x1

	##

	for x1 in "${bundle_name_list[@]}" ; do

		xx :
		xx brew bundle install --file="${x1}"
	done
}
