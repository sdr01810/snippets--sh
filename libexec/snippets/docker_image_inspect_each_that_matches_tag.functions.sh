function docker_image_inspect_each_that_matches_tag() { # docker_image_tag

	local docker_image_tag="${1}"

	! [ -z "${docker_image_tag}" ] || return

	docker image list | perl -alne '
	
		next unless ($F[1] =~ m{^'"${docker_image_tag:?}"'(?:-COMMON-BEHAVIOR)?$}) ;

		print "$F[0]\t$F[1]\t$F[2]" ;

	' | sort |

	while read -r docker_image_repo docker_image_tag docker_image_id ; do

	        xx :
		xx docker inspect "${docker_image_repo:?}:${docker_image_tag:?}"
	done
}
