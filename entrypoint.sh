#!/bin/bash

rm -f /rover/tmp/pids/server.pid

exec "$@"
