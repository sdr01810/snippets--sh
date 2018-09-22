function xx() { # ...

	echo 1>&2 "+" "$@"
	"$@"
}
