function with_allowed_termination_signal() { # signal_name command ...

	local signal_name="${1:?}" ; shift
	local signal_number="$(kill -l SIG${signal_name#SIG})"

	local signal_as_xc=$(( 128 + ${signal_number:?} ))
	local xc=0

	( "$@" ) || xc=$?

	case "${xc}" in 
	${signal_as_xc})
		xc=0
		;;
	esac

	return $xc
}
