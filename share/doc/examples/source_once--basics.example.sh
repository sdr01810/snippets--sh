#!/usr/bin/env bash
## Example program that shows sample_once() basics.
##
## Typical use:
##
##     ./sample_once--basics.example.sh
##

set -e

set -o pipefail 2>&- || :

this_script_dpn="$(cd "$(dirname "$0")" && pwd -P)"

this_package_dpn="${this_script_dpn%/share/*}"

##

export PATH="${this_package_dpn:?}/libexec:${PATH}"

source source_once.functions.sh

source_once snippets/hello_world
source_once snippets/xx

##

function main() { #

	xx :
	xx hello_world

	xx :
	xx set | egrep '^source_once_module_rc__' || :
}

main "$@"

## EOF
