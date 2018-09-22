function docker_image_list_each_that_matches() { # [docker_image_match_predicate_expression]

	local docker_image_match_predicate_expression="${1:-0}"

	docker image list | perl -e '

		my $match_predicate_expression = shift(@ARGV);

		while( <> ) {

			if ($. == 1) {
	
				if (m{REPOSITORY\s+TAG\s+(?:IMAGE\s+)?ID\b}) {
	
					print ;
				}
				else {
					die "Looks like the format of a docker image list has changed; aborting." ;
				}
			}
			else {
				my ($repo, $tag, $id, @rest) = split ; my $name = "${repo}:${tag}" ;
	
				my $match_p = eval $match_predicate_expression ; 

				print if ($match_p) ;
			}
		}
	
	' "${docker_image_match_predicate_expression:?}";
}

