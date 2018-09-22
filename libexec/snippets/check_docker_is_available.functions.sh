function check_docker_is_available() {

	docker_is_available || {

	        echo 1>&2 "Looks like docker is not available; aborting."
	        false
	}
}
