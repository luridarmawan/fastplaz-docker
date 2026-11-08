#!/bin/bash
echo FastPlaz - Run Container
echo

OS=$1
RELEASE=$2
if [ "$1" ==  "" ]
then
	OS="ubuntu"
fi
if [ "$2" ==  "runtime" ]
then
	if [ "$OS" ==  "ubuntu" ]
	then
		RELEASE=""
	else
		RELEASE="-runtime"
	fi
else
	RELEASE=""
fi
echo Run: $OS $RELEASE

docker run -it -p 8080:80 fastplaz/$OS$RELEASE
#docker run -it -v ~/shared-folder:/shared-folder -p 8080:80 fastplaz/$OS$RELEASE

