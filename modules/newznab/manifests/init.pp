class newznab {

	$dlName="newznab-0.2.3"
	$dlFileName="${dlName}.zip"
	$dlUrl="http://www.newznab.com/${dlFileName}"

	exec{ "get-newznab":
		command => "/usr/bin/wget $dlUrl",
		cwd => "/tmp",
		creates => "/tmp/$dlFileName",
	}

	exec { "unpack-newznab":
		command => "/usr/bin/unzip $dlFileName",
		creates => "/tmp/$dlName/INSTALL.txt",
		cwd => "/tmp",
		require => [
			Exec["get-newznab"],
		],
	}
		
	file { "/var/www":
		source => "/tmp/$dlName/www",
		recurse => true,
		ensure => "present",
	}

	/*
	 * From newznab installer:
	 *
	 * The template cache folder must be writable. A quick solution is to run:
	 * chmod 777 /var/www/lib/smarty/templates_c
	 */
	file { "/var/www/lib/smarty/templates_c":
		mode => "a+rwx",
	}
}
