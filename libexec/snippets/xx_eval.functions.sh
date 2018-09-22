function xx_eval() { # ...

	echo 1>&2 "+" eval "$@"
	eval "$@"
}
