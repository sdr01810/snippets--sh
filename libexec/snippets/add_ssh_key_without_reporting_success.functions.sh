function add_ssh_key_without_reporting_success() { # ...

	(ssh-add "$@" >/dev/null) 2>&1 | (egrep -v '^Identity added:' || :) 1>&2
}
