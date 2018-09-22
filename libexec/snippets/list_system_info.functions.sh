function list_system_info() { # [detail_level]

	local detail_level="${1:-mini}"
	local f1
	local d1

	xx :
	xx uname -a || :

	for f1 in /etc/*-release ; do
		[ -e "${f1:?}" ] || break

		xx :
		xx head -9999 /etc/*-release || :
		break
	done

	if hash system_profiler 2>&- ; then

		xx :
		xx system_profiler -detailLevel "${detail_level:?}" || :

		for d1 in /System/Library/Extensions /Library/Extensions /Applications "${HOME:?}"/Applications ; do
			[ -d "${d1:?}" ] || continue

			xx :
			xx find -H "${d1:?}" -maxdepth 8 -type d \( -name '*.app' -o -name '*.kext' \) -print0 | xx xargs -0 ls -lhd || :
		done
	fi
}
