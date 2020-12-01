#!/usr/bin/env sh

# Collect version info from a git repo and write it to a file #################
# $1    the file
###############################################################################
sha1=`git rev-parse --verify HEAD 2> /dev/null`
sha1_short=`git rev-parse --short --verify HEAD 2> /dev/null`
branch=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
committime=`git show -s --format=%cd $sha1 2> /dev/null`

cat <<EOT > "$1"
  sha1 short    $sha1_short
  sha1          $sha1
  commit time   $committime
  branch        $branch
EOT
