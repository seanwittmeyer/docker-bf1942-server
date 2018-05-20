#!/bin/bash

# init env
BFSM=${BFSM:-}
BFSM_PORT=${BFSM_PORT:-22999}

cd /bf1942 || exit 1

# start bfsm
if [[ "$BFSM" != "" ]]; then
    ./bfsmd -ip $(hostname -i) -port "$BFSM_PORT" -quit -daemon
fi

# start server
./bf1942_lnxded +statusMonitor 1
