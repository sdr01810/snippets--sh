function omit_wsac() { # args like cat(1)

	cat "$@" | perl -ne '

		s{\s*[#].*$} {} ;

		print unless m{^\s*$} ;
	';
}
