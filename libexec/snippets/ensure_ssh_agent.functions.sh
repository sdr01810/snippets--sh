function ensure_ssh_agent() {

	eval "$(ssh-agent -s)"
}
