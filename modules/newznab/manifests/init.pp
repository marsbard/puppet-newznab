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
		

}
