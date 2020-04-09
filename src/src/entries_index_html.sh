#!/bin/bash
set -eu

SITE_ROOT="$1"

cat <<__EOF__
<!DOCTYPE html>
<meta charset="utf-8">
<meta http-equiv="refresh" content="0; url=$SITE_ROOT/">
<title></title>
__EOF__
