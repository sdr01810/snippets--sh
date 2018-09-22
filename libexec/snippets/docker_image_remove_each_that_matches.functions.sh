function docker_image_remove_each_that_matches() { # [docker_image_match_predicate_expression]

	docker_image_list_each_that_matches "$@" |
		
	sed -e 1d | # omit banner line

	while read -r repo tag rest ; do

		docker image rm --force "${repo}:${tag}"
	done
}
