function install_listed_brew_packages() { # args like cat(1)

	(
		echo "t: homebrew/bundle"
		echo "t: homebrew/cask"
		echo "t: homebrew/cask-versions"

		echo "x: bundle"
		echo "x: cask"
		echo "f: mas"

		#^-- required entries
		
		cat "$@"

	) | omit_wsac | perl -lne '

		if (m{^(?:([\w])[:])?\s+(\S+)\s*(\S.*)?$}i) {
		#         ^             ^       ^
		#         ^             ^       ^-- args
		#         ^             ^-- name
		#         ^-- type

			my ($type, $name, $options_unsplit) = ($1, $2, $3) ;

			##

			my @installer_command;

			if (0) {}
			elsif ($type =~ m{^[a]$}) {

				$installer_command = "mas install $(qq "$name") $options_unsplit" ;
			}
			elsif ($type =~ m{^[b]$}) {

				$installer_command = "brew install --file=$(qq "$name") $options_unsplit" ;
			}
			elsif ($type =~ m{^[c]$}) {

				$installer_command = "brew cask install $(qq "$name") $options_unsplit" ;
			}
			elsif ($type =~ m{^[f]$}) {

				$installer_command = "brew install $(qq "$name") $options_unsplit" ;
			}
			elsif ($type =~ m{^[t]$}) {

				$installer_command = "brew tap $(qq "$name") $options_unsplit" ;
			}
			elsif ($type =~ m{^[x]$}) {

				$installer_command = "brew $(qq "$name") --version $options_unsplit" ; # auto-installed on first use
			}
			else {

				warn "Unrecognized package type; skipping: $_" ;
				next ;
			}

			#^-- TODO: srogers: add support for performing reinstall instead of install.

			print "$installer_command" ;
		}
		else {

			warn "Unrecognized package entry; skipping: $_" ;
			next ;
		}

		#

	' | omit_wsac |

	while read -r command ; do

		xx :
		xx ${command:?} || exit $?

	done || rc=$?

	case ${rc:-0} in
	0)
		echo 1>&2
		echo 1>&2 "INSTALLATION SUCCEEDED"
		;;
	*)
		echo 1>&2
		echo 1>&2 "INSTALLATION FAILED; EXIT CODE: ${rc:?}"
		;;
	esac
	return ${rc:-0}
}
