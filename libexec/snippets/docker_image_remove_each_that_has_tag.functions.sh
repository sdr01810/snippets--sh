function docker_image_remove_each_that_has_tag() { # docker_image_tag

	local docker_image_tag="${1:?missing argument: docker_image_tag}"

	docker image list | perl -alne '
	
		next unless ($F[1] eq "'"${docker_image_tag:?}"'") ;

		print "$F[0]\t$F[1]\t$F[2]" ;

	' | sort | 

	while read -r docker_image_name docker_image_tag docker_image_id ; do

	        xx :
		xx docker image rm "${docker_image_name:?}:${docker_image_tag:?}"
	done
}
