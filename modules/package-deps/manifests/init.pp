class package-deps {
	
    	$packages = [ 
 	] 
    
	$rmpackages = [ 
	]

    	package { $packages:
        	ensure => "present", 
        	require => Exec["apt-get update"],
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