#!/bin/sh

cd "`dirname $0`"

#echo Installing puppet modules...
#./install-puppet-modules.sh 2>&1 > /dev/null

#echo Puppet modules installed
#echo

if [ ! -f "IS_REMOTE" ]
then
    echo 
    echo "Be careful applying this to your local machine, use vagrant instead"
    echo "or else your apache config (if you have one) will be destroyed."
    echo
    echo "If this really is the remote machine, then issue the following command:"
    echo
    echo "  touch `pwd`/IS_REMOTE"
    echo
    echo "Otherwise simply use:"
    echo
    echo "  vagrant up"
    echo
    exit
fi



sudo puppet apply -v -d --modulepath="./modules:./extmodules" manifests/default.pp
