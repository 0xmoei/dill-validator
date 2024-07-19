#! /bin/bash

usage(){
    echo "usage:" 
    echo "      $0"
    echo "to print verbose information:"
    echo "      $0 -v"
}

if [ $# -gt 1 ];then
    usage
    exit
fi

if [ $# -eq 1 ] && [ "$1" != "-v" ];then
    usage
    exit
fi

if [ "$1" == "-v" ]; then
    verbose="yes"
fi

tlog() {
    echo "$(date '+%Y-%m-%d %H:%M:%S %Z') > $*"
}

vlog(){
    if [ -z "${verbose}" ]; then
        return
    fi
    echo "$(date '+%Y-%m-%d %H:%M:%S %Z') > $*"
}

is_running=`ps -ef | grep dill | grep -v grep | grep 0x1a5E568E5b26A95526f469E8d9AC6d1C30432B33`

if [ ! -z "$is_running" ]; then
    vlog "node running"
else 
    tlog "node not running"
    exit 1
fi

peers_count=`curl -s localhost:8081/p2p | grep -m 1  peers | awk '{print $1}'`
vlog "node peers count $peers_count"
if [ $peers_count -gt 0 ]; then
    vlog "node's network connectivity check passed"
else
    vlog "node has no peers for now, please wait for 30s and re-run this script"
    tlog "connectivity check failed, please wait and retry this script"
    exit 1
fi

syncing_res=`curl -s localhost:3500/eth/v1/node/syncing`
done=`echo $syncing_res | grep "\"is_syncing\":false"`
slot=`echo $syncing_res | grep  -o -E "[0-9]*" | head -n 1`
if [ ! -z "$done" ]; then
    vlog "Synchronization done, current slot is ${slot}"
    tlog "Node health check passed."
else
    vlog "node is synchronizing, current slot is ${slot}"
    tlog "Node health check passed."
fi
