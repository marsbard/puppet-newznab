class php {

        case $operatingsystem {
                centos: {
                        $apache = "httpd"
                }
                # Note that these matches are case-insensitive.
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


	file { "/etc/php5/apache2/php.ini":
		source => "puppet:///modules/php/etc-php5-apache2-php.ini",
		ensure => "present",
	}

	file { "/etc/php5/cli/php.ini":
		source => "puppet:///modules/php/etc-php5-cli-php.ini",
		ensure => "present",
	}


	service { "$apache": 
		ensure => "running",
	}
}
