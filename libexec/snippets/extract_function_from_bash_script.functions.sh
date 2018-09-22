function extract_function_from_bash_script() { # bash_script_fpn function_name

	local bash_script_fpn="${1:?}" ; shift
	local function_name="${1:?}" ; shift

	[ $# -eq 0 ]

	##

	cat "${bash_script_fpn:?}" | perl -lne '

		print if (/^\s*(?:function\s)?\s*'"${function_name:?}"'\s*\(\)/ .. /^}/) ;
	';
}
