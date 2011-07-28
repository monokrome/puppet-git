class git::user {
	user {
		"git":
			ensure => present,
			uid => 500,
			shell => "/bin/sh",
			home => "/home/git",
			managehome => true,
	}
}

