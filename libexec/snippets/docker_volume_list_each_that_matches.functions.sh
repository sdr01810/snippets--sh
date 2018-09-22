function docker_volume_list_each_that_matches() { # [docker_volume_match_predicate_expression]

	local docker_volume_match_predicate_expression="${1:-0}"

	docker volume list | perl -e '

		my $match_predicate_expression = shift(@ARGV);

		while( <> ) {

			if ($. == 1) {
	
				if (m{DRIVER\s+VOLUME NAME\b}) {
	
					print ;
				}
				else {
					die "Looks like the format of a docker volume list has changed; aborting." ;
				}
			}
			else {
				my ($driver, $name, @rest) = split ;
	
				my $match_p = eval $match_predicate_expression ; 

				print if ($match_p) ;
			}
		}
	
	' "${docker_volume_match_predicate_expression:?}";
}
