function install_brew_formula() { # [formula_name ...]

	local formula_name_list=( "$@" )
	local x1

	##

	for x1 in "${formula_name_list[@]}" ; do

		xx :
		xx brew install "${x1}"
	done
}
