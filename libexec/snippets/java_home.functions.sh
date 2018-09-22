function java_home() { # ...

	case "${OSTYPE}" in
	darwin*)
		/usr/libexec/java_home "$@"
		;;
	*)
		echo 1>&2 "Unsupported operating system: ${OSTYPE}."
		false
		;;
	esac
}
