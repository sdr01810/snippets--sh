function error_unrecognized_argument() { # ...

	echo 1>&2 "Unrecognized argument:" "$@"
	false
}

