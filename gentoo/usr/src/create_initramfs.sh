#!/bin/sh

add_deps() {
	for L in $(lddtree -l $1) ; do
		mkdir -p /usr/src/initramfs$(dirname $L)
		cp -u -v -L $L /usr/src/initramfs$L
		[ $1 != $L ] && add_deps $L
	done
}

add_deps $1
