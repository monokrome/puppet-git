class git::gitolite {
	include git
	include git::user

	$gitolite_prefix = "/usr/local"
	$gitolite_admin = "monokrome"

	git::clone {
		"gitolite":
			url => "https://github.com/sitaramc/gitolite.git",
			cwd => "/home/git",
			target => "gitolite-src",
			user => "git",
	}

	exec {
		"gitolite-install":
			cwd => "/home/git/gitolite-src/",
			command => "gl-system-install ${gitolite_prefix}/bin ${gitolite_prefix}/share/gitolite/conf ${gitolite_prefix}/share/gitolite/hooks",
			path => ["/home/git/gitolite-src/src/", "/usr/sbin", "/bin", "/usr/bin", "/usr/local/bin"],
			subscribe => Exec["git::clone::gitolite"],
			refreshonly => true,
	}

	file {
		"/tmp/${gitolite_admin}.pub":
			name => "/tmp/${gitolite_admin}.pub",
			mode => 440,
			owner => "git",
			content => "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEArwyGxQbNbc/ASCovTFo8Lz05tAb5Q9cRGM96jIW7UFt0qpXwBI5paT1LJaGicQ//iEhrFWkm342ffgpkrJOez5sQz1oPbNY3DMRYd7JNQuXADAlTMALrEI56dc29KMIScE4A6fBxblIaWqXsgl7us1Llmj/xA+Es7No8sw0UlTCL9OSgvTtMyabuwROtLEDuIWbCjWdrBem2M7nBVR25xQEwSxohfJ3TgNVgipKDB+ypsUKTpkD8BSy6gaRRZGXoiCcuUyNkwLG7vls/5hnxxIcJA22E353Ucw8a+AAWD6Uh8iDxuY15Ey6GU6/v1GNQwm/SSnC8kJDDGXaFujm8gw== monokrome@Brandon-R-Stoners-MacBook-Pro.local",
	}

	exec {
		"gitolite-setup":
			cwd => "/home/git",
			command => "su git -c 'gl-setup -q /tmp/${gitolite_admin}.pub'",
			path => ["/bin", "/usr/bin", "/usr/local/bin"],
			require => File["/tmp/${gitolite_admin}.pub"],
			subscribe => Exec["gitolite-install"],
			refreshonly => true,
	}
}

