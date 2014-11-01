class "newznab" {

	$dlName="newznab-0.2.3.zip"
	$dlUrl="http://www.newznab.com/${dlName}"

	exec{ "get-newznab":
		command => "/usr/bin/wget $dlUrl",
		cwd => "/tmp",
		creates => "/tmp/$dlName",
	}

	exec { "unpack-newznab":
		command => "/usr/bin/unzip $dlName",
		cwd => "/tmp",
		require => [
			Exec["get-newznab"],
		],
	}
		

}
