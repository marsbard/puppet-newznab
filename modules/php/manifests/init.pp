class php {

	file { "/etc/php5/apache2/php.ini":
		source => "puppet:///php/etc-php5-apache2-php.ini",
		ensure => "present",
	}

	file { "/etc/php5/cli/php.ini":
		source => "puppet:///php/etc-php5-cli-php.ini",
		ensure => "present",
	}


}
