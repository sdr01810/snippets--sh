function gnu_backup_option_is_supported_by_command() { # command_name_or_pn

	local command_name_or_pn="${1}"

        [ -n "${command_name_or_pn}" ] &&

        { ("${command_name_or_pn}" --backup 2>&1 || :) | egrep -q '\bmissing\b.*\b(file|operand)'; }
}
