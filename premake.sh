#!/usr/bin/env bash

MY_DIR=${PWD}

error_exit()
{
	echo "$1" 1>&2
	exit 1
}

source "./tools/packman/packman" pull "./tools/packman/host-deps.packman.xml" -p linux-x86_64 || error_exit "There was an error running packman."

"./_packman-packages/host-deps/premake/premake5" gmake --file="${MY_DIR}/premake5.lua" --os=linux || error_exit "Error while generating projects with premake"
