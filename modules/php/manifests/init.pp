class php {
	include "php::$operatingsystem"
}


class php::common {

}

class php::centos inherits php::common {
	service { "httpd":
		ensure => "running",
		require => [
			File["/etc/php.ini"],
		],
	}	

	file { "/etc/php.ini":
		source => "puppet:///modules/php/etc-php5-apache2-php.ini",
		ensure => "present",
	}

}

class php::redhat inherits php::centos {}

class php::debian inherits php::common {
	service { "apache2":
		ensure => "running",
		require => [
			File["/etc/php5/apache2/php.ini"],
			File["/etc/php5/cli/php.ini"],
		],
	}	

	file { "/etc/php5/apache2/php.ini":
		source => "puppet:///modules/php/etc-php5-apache2-php.ini",
		ensure => "present",
	}

	file { "/etc/php5/cli/php.ini":
		source => "puppet:///modules/php/etc-php5-cli-php.ini",
		ensure => "present",
	}

}

class php::ubuntu inherits php::debian {}
