#!/bin/sh
ps -axo pid,command,args | grep -i "$@" | awk '{ print $1 }'