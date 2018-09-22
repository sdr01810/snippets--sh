	while [ $# -gt 0 ] ; do
		case "${1}" in
		--force)
			force_p=t
			shift
			;;
		--)
			shift
			break
			;;
		*)
			break
			;;
		esac
	done
