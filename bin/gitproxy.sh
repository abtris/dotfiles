#!/bin/sh
nc -X 5 -x 127.0.0.1:1080 "$@"
