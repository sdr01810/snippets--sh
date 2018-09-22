#!/usr/bin/env bash
## Example program that loads a snippet to say 'Hello world'.
##
## Typical use:
##
##     ./hello-world.example.sh
##

set -e

set -o pipefail 2>&- || :

this_script_dpn="$(cd "$(dirname "$0")" && pwd -P)"

this_package_libexec_dpn="${this_script_dpn%/share/*}"/libexec

##

export PATH="${this_package_libexec_dpn:?}/snippets:${PATH}"

source hello_world.functions.sh

##

function main() { #

	hello_world
}

main "$@"

## EOF
