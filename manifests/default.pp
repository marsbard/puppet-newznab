
# if you need to add packages to help build or deploy your addon, add them
# in to package-deps and they will be installed prior to any builds
stage { 'first':
        before => Stage['main'],
}
class { "package-deps":
        stage => first,
}


stage { 'last':
	require => Stage['main'],
}
class { "php":
	stage => last,
}

include "php"
include "newznab"
