#!/bin/bash
## Extract the specified function from the specified Bash script, printing it on stdout.
##
## Typical use:
##
##     extract-function-from-bash-script script-that-uses-a-copy-of-function-hello-world.sh hello_world
##

set -e

set -o pipefail 2>&- || :

this_script_fbn="$(basename "${0}")"
this_script_stem="${this_script_fbn%.*sh}"

##
## from snippets library:
##

function qq() { # ...

	printf %q "$@"
}

function xx() { # ..

	echo 1>&2 "+" "$@"
	"$@"
}

function xx_eval() { # ...

	echo 1>&2 "+" eval "$@"
	eval "$@"
}

function extract_function_from_bash_script() { # bash_script_fpn function_name

	local bash_script_fpn="${1:?}" ; shift
	local function_name="${1:?}" ; shift

	[ $# -eq 0 ]

	##

	cat "${bash_script_fpn:?}" | perl -lne '

		print if (/^function '"${function_name:?}"'\(\)/ .. /^}/) ;
	';
}

##
## core logic:
##

function main() { # ...

	extract_function_from_bash_script "$@"
}

main "$@"

##

