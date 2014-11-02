class package-deps {
	
    	$packages = [ 
		"apache2",
		"unzip",
		"libapache2-mod-php5",
		"php5-mysql",
		"php5-curl",
		"php5-gd",
		"php-pear",
		"mysql-server",
		"mysql-client",
 	] 
    
	$rmpackages = [ 
	]

    	package { $packages:
        	ensure => "present", 
        	require => Exec["apt-get update"],
		notify => Service["apache2"],
    	}

	package { $rmpackages:
		ensure => "absent",
	}

    	#exec { "apt-get upgrade":
	#	require => Exec["apt-get update"],
	#	path => "/bin:/usr/bin",
	#	command => "apt-get upgrade -y",
	#	environment => "DEBIAN_FRONTEND=noninteractive",
	#	timeout => 0,
	#}

    	exec { "apt-get update":
		path => "/bin:/usr/bin",
	}

}
