function display_notification() { # message title subtitle

	local message="${1}" title="${2}" subtitle="${3}"

	case "$OSTYPE" in
	darwin*)
		osascript -e '

			display notification "'"${message}"'" with title "'"${title}"'" subtitle "'"${subtitle}"'
		';
		;;
	esac
}

