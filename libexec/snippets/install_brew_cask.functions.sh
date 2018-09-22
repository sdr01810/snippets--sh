function install_brew_cask() { # --replace-non-cask arg_for_brew_cask_install ...

	local replace_non_cask_p=
	local force_was_specified_p=
	local brew_cask_install_arg_list=()

	while [ $# -gt 0 ] ; do
		case "${1}" in
		--replace-non-cask)
			replace_non_cask_p=t
			shift
			;;
		--no-replace-non-cask)
			replace_non_cask_p=
			shift
			;;
		--force)
			brew_cask_install_arg_list+=( "${1}" )
			force_was_specified_p=t
			shift
			;;
		--language)
			brew_cask_install_arg_list+=( "${1}=${2}" )
			shift 2
			break
			;;
		--language=*|--require-sha|--skip-cask-deps)
			brew_cask_install_arg_list+=( "${1}" )
			shift
			break
			;;
		--)
			shift
			break
			;;
		*|'')
			break
			;;
		esac
	done

	brew_cask_install_arg_list+=( "$@" ) ; shift $#

	[ $# -eq 0 ]

	##

	if brew cask install "${brew_cask_install_arg_list[@]}" ; then

		true
	else
	if [ -n "${replace_non_cask_p}" -a ! -n "${force_was_specified_p}" ] ; then

		brew cask install --force "${brew_cask_install_arg_list[@]}"
	fi;fi
}
