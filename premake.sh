#!/usr/bin/env bash

error_exit()
{
	echo "$1" 1>&2
	exit 1
}

source "./tools/packman/packman" pull "./tools/packman/host-deps.packman.xml" -p linux-x86_64 || error_exit "There was an error running packman."

"%PM_premake_PATH%/premake5" --file=premake5.lua --os=linux || error_exit "There was an error running premake."