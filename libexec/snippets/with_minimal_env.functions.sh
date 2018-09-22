function with_minimal_env() { # ...

	local env_settings=(
		HOME="$(qq "$HOME")"
		LOGNAME="$(qq "$LOGNAME")"
		USER="$(qq "$USER")"

		PATH="$(qq "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin")"

		PWD="$(qq "$PWD")"

		SHELL="$(qq "$SHELL")"
		SHLVL="$(qq "$SHLVL")"

		TERM="$(qq "$TERM")"
		ROWS="$(qq "$ROWS")"
		COLUMNS="$(qq "$COLUMNS")"
	)

	(eval "xx env - ${env_settings[@]}" '"$@"')
}
