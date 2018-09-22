function docker_image_remove_each_that_matches_tag() { # docker_image_tag

	#^-- TODO: stephen.rogers: add support for `docker image rm` options like --force

	local docker_image_tag="${1:?missing argument: docker_image_tag}"

	docker image list | perl -alne '
	
		next unless ($F[1] =~ m{^'"${docker_image_tag:?}"'(?:-COMMON-BEHAVIOR)?$}) ;

		print "$F[0]\t$F[1]\t$F[2]" ;

	' | 

	while read -r docker_image_repo docker_image_tag docker_image_id ; do

	        xx :
		xx docker image rm --force "${docker_image_repo:?}:${docker_image_tag:?}"
	done
}
