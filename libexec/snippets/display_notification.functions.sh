function display_notification() { # message title subtitle

	local message="${1}" title="${2}" subtitle="${3}"

	echo 1>&2
	echo 1>&2 "${title}${title:+: }${subtitle}${subtitle:+: }${message}"

	case "$OSTYPE" in
	darwin*)
		osascript -e '

			display notification "'"${message}"'" with title "'"${title}"'" subtitle "'"${subtitle}"'"
		';
		;;
	esac
}
