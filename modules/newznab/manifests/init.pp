
class newznab {
	include "newznab::$operatingsystem"
}

class newznab::common {

	$dlName="newznab-0.2.3"
	$dlFileName="${dlName}.zip"
	$dlUrl="http://www.newznab.com/${dlFileName}"

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
			$webDir = "/var/www/html" 
		}
      		redhat : { $webDir = "/var/www/html" 
		}
      		debian: { $webDir = "/var/www" 
		}
      		ubuntu: { $webDir = "/var/www" 
		}
      		default: { fail("Unrecognized operating system for webserver") }
    	}
	
	$installDir = "${webDir}/newznab"


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

	file { "${webDir}/db":
		ensure => "directory",
		source => "/tmp/$dlName/db",
		recurse => true,
		require => File["${installDir}"],
	}

		
	file { "${installDir}":
		source => "/tmp/$dlName/www",
		recurse => true,
		ensure => "directory",
		require => [
			Exec["unpack-newznab"],
		],
	}

	/*
	 * From newznab installer:
	 *
	 * The template cache folder must be writable. A quick solution is to run:
	 * chmod 777 ${installDir}/lib/smarty/templates_c
	 */
	file { "${installDir}/lib/smarty/templates_c":
		ensure => "directory",
		mode => "777",
		require => [
			File["${installDir}"],
		],
	}

	file { "/tmp/setperms.sh":
		ensure => "present",
		mode => "777",
		content => "PATH=/bin:/usr/bin\nchmod a+rwx ${installDir}/{,covers/movies,covers/music,install}",
		require => [
			File["${installDir}"],
		],
	}

	file { "${installDir}/index.html":
		ensure => "absent",
		require => [ 
			File["${installDir}"],
		],
	}

	exec { "/tmp/setperms.sh":
		command => "/bin/bash /tmp/setperms.sh",
		path => "/bin:/usr/bin",
		logoutput => "on_failure",
		require => [
			File["/tmp/setperms.sh"],
		],
	}


}

class newznab::ubuntu inherits newznab::common {

	exec { "/usr/sbin/a2enmod rewrite":
		require => Package["${apache}"],
		notify => Service["${apache}"],
	}
	
}


class newznab::centos inherits newznab::common {

	# rewrite should be loaded already

}

