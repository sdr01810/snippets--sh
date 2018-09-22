function resolved_pathname() { # value

	local have_realpath_p=t
	! hash realpath 2>&- || have_realpath_p=

	resolved_pathname__recursive "${have_realpath_p}" "$@"
}

