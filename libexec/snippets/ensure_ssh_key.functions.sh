function ensure_ssh_key() { # [--gen-type dsa | ecdsa | ed25519 | rsa] ssh_key_fpn [ssh_key_alternative_fpn ...]

	eval local $(define_return_codes_for_ensure_ssh_key)

	local ssh_key_comment_if_generated=
	local ssh_key_type_if_generated=

	while [ $# -gt 0 ] ; do
	case "${1}" in
	--)
		shift
		break
		;;
	--gen-type)
		ssh_key_type_if_generated="${2:?}"
		shift 2
		;;
	-*)
		error_unrecognized_argument "${1}" || :
		return ${ensure_ssh_key_rc_internal_error:?}
		;;
	*)
		break
		;;
	esac;done

	local ssh_key_fpn_candidate_list=( "$@" )
	
	local rc
	local f1

	##

	[ "${#ssh_key_fpn_candidate_list[@]}" -gt 0 ]

	for f1 in "${ssh_key_fpn_candidate_list[@]}" ; do

		! [ -n "$f1" ] || continue
		! [ -e "$f1" ] || break
	done
	[ -n "${f1}" ]

	local ssh_key_fpn="${ssh_key_fpn_candidate_list[0]}"
	local ssh_key_fbn="$(basename "${ssh_key_fpn:?}")"

	if [ -e "${ssh_key_fpn:?}" ] ; then

		rc=${ensure_ssh_key_rc_already_existed_and_add_succeeded:?} # presumptive success

		xx :	
		add_ssh_key_without_reporting_success "${ssh_key_fpn:?}" ||
		rc=${ensure_ssh_key_rc_already_existed_and_add_failed:?} # actual failure
	else
		local ssh_key_type_inferred="$(infer_ssh_key_type_from_file_name_but_not_contents "${ssh_key_fpn:?}" || :)"

		! [ -n "${ssh_key_type_if_generated}" ] ||
		ssh_key_type_pair_is_compatible "${ssh_key_type_if_generated}" "${ssh_key_type_inferred}" || {

			echo 1>&2 "Auto-generation key type (${ssh_key_type_if_generated}) is not compatible with key file name: ${ssh_key_fpn:?}"
			(false ; return)
		}
	
		rc=${ensure_ssh_key_rc_auto_generate_succeeded:?} # presumptive success
	
		if [ -e "${f1:?}" ] && [ "${f1:?}" != "${ssh_key_fpn:?}" ] ; then
	
			xx :
			xx ln -snf "${f1:?}" "${ssh_key_fpn:?}" ||
			rc=${ensure_ssh_key_rc_auto_generate_failed:?} # actual failure
		else
			local ssh_key_comment_default="${ssh_key_fbn:?}"
		
			local ssh_key_password="$(eval

				"${BDS_HUB_BACKEND_SOURCE_VCS_SSH_KEY_PASSWORD_GENERATOR[@]}"
			)"

			local ssh_keygen_option_list=( )
			ssh_keygen_option_list+=( -f "$(qq "${ssh_key_fpn:?}")" )
			ssh_keygen_option_list+=( -N "$(qq "${ssh_key_password}")" )
			ssh_keygen_option_list+=( -t "$(qq "${ssh_key_type_if_generated:-${ssh_key_type_default:?}}")" )
			ssh_keygen_option_list+=( -C "$(qq "${ssh_key_comment_if_generated:-${ssh_key_comment_default}}")" )
	
			xx :	
			xx_eval ssh-keygen "${ssh_keygen_option_list[@]}" ||
			rc=${ensure_ssh_key_rc_auto_generate_failed:?} # actual failure
		fi
	fi

	case ${rc:?} in
	${ensure_ssh_key_rc_already_existed_and_add_succeeded:?})
		echo 1>&2 "Added existing SSH key to agent: ${ssh_key_fpn:?}"
		;;

	${ensure_ssh_key_rc_already_existed_and_add_failed:?})
		echo 1>&2 "Failed to add existing SSH key to agent: ${ssh_key_fpn:?}"
		;;

	${ensure_ssh_key_rc_auto_generate_succeeded:?})
		echo 1>&2 "Generated SSH key: ${ssh_key_fpn:?}"
		echo 1>&2 "Re-provision after registering that key with the necessary remote service(s)."
		;;

	${ensure_ssh_key_rc_auto_generate_failed:?})
		echo 1>&2 "Failed to generate SSH key: ${ssh_key_fpn:?}"
		;;
	esac

	return ${rc:?}
}
