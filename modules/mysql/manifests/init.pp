class mysql {

	file { "/etc/mysql/my.cnf" :
		source => "puppet:///modules/mysql/my.cnf",
		ensure => "present",
	}

}
