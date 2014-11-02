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


        case $operatingsystem {
                centos: { $updateCommand = "yum -y update" }
                # Note that these matches are case-insensitive.
                redhat : { $updateCommand = "yum -y update" }
                debian: { $updateCommand = "apt-get update" }
                ubuntu: { $updateCommand = "apt-get update" }
                default: { fail("Unrecognized operating system") }
        }
   
    	package { $packages:
        	ensure => "present", 
        	require => Exec["update-pkglist"],
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

    	exec { "update-pkglist":
		command => "${updateCommand}",
		path => "/bin:/usr/bin",
	}



}
