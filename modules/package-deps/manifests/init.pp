class package-deps {
	
    	$debpackages = [ 
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

	$rhpackages = [
		"unzip",
		"httpd", "php", "mysql-server", "mysql", "memcached", "php-mysql",
		"php-gd", "php-pear", "mod_ssl", "curl", "php-process",
		"wget",
	]
 
	$rmpackages = [ 
	]

        case $operatingsystem {
                centos: {
                        $apache = "httpd"
                }
                redhat : {
                        $apache = "httpd"
                }
                debian: {
                        $apache = "apache2"
                }
                ubuntu: {
                        $apache = "apache2"
                }
                default: { fail("Unrecognized operating system for webserver") }
        }


        case $operatingsystem {
                centos: { 
			$updateCommand = "yum -y update" 
			$packages = $rhpackages
		}
                redhat : { 
			$updateCommand = "yum -y update" 
			$packages = $rhpackages
		}
                debian: { 
			$updateCommand = "apt-get update" 
			$packages = $debpackages
		}
                ubuntu: { 
			$updateCommand = "apt-get update" 
			$packages = $debpackages
		}
                default: { fail("Unrecognized operating system") }
        }
   
    	package { $packages:
        	ensure => "present", 
        	require => Exec["update-pkglist"],
		notify => Service["$apache"],
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
