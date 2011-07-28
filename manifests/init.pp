class git {
	import "definitions/*.pp"

	package {
		'git-core':
			ensure => latest
	}
}

