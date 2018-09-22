function install_package_brew() { #

	local pnp="${BREW_BOOTSTRAP_PACKAGE_BREW_INSTALLATION_SCRIPT_PNP:?}"

	local package_brew_installation_redo_script_fpn="$(echo \
		"${pnp:?}${BREW_BOOTSTRAP_PACKAGE_BREW_INSTALLATION_REDO_SCRIPT_SUFFIX:?}"
	)"
	local package_brew_installation_undo_script_fpn="$(echo \
		"${pnp:?}${BREW_BOOTSTRAP_PACKAGE_BREW_INSTALLATION_UNDO_SCRIPT_SUFFIX:?}"
	)"

	##

	check_package_brew_installation_root \
		"${BREW_BOOTSTRAP_PACKAGE_BREW_INSTALLATION_ROOT_DPN:?}" #

	##

	briefly_cache_sudo_authentication

	ensure_backup_of_package_brew_installation_root \
		"${BREW_BOOTSTRAP_PACKAGE_BREW_INSTALLATION_ROOT_DPN:?}" \
		"${BREW_BOOTSTRAP_PACKAGE_BREW_INSTALLATION_ROOT_BACKUP_FPN:?}" #

	ensure_download_of_package_brew_installation_script \
		"${package_brew_installation_redo_script_fpn:?}" \
		"${BREW_BOOTSTRAP_PACKAGE_BREW_INSTALLATION_REDO_SCRIPT_URL:?}" #

	ensure_download_of_package_brew_installation_script \
		"${package_brew_installation_undo_script_fpn:?}" \
		"${BREW_BOOTSTRAP_PACKAGE_BREW_INSTALLATION_UNDO_SCRIPT_URL:?}" #

	xx :
	xx without_interaction /usr/bin/ruby "${package_brew_installation_redo_script_fpn:?}"
}
