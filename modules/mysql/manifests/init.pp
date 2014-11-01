class mysql {

	file { "/etc/mysql/my.cnf" :
		source => "puppet:///mysql/my.cnf",
		ensure => "present",
	}

}
