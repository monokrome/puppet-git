class git {
	import "definitions/*.pp"

	$package_name = $operatingsystem ? {
		Ubuntu => "git-core",
		default => "git",
	}

	package {
		"${package_name}":
			ensure => latest
	}
}

