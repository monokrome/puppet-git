define git::clone ($url, $cwd, $target, $pull = true, $user = "root") {
	$command = "git clone '${url}' '${target}'"
	$output_file = "${cwd}/${target}/.git"

	exec {
		"git::clone::${name}":
			command => "git clone '${url}' '${target}'",
			cwd => "${cwd}",
			creates => $output_file,
			user => $user,
			path => ["/usr/bin", "/usr/sbin", "/usr/local/bin"],
	}
}

