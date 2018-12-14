#!/bin/sh

# check for where the latest version of IDEA is installed
CLion=`ls -1d /Applications/CLion.app | tail -n1`
wd=`pwd`

# were we given a directory?
if [ -d "$1" ]; then
# echo "checking for things in the working dir given"
  wd=`ls -1d "$1" | head -n1`
fi

# were we given a file?
if [ -f "$1" ]; then
# echo "opening '$1'"
  open -a "$CLion" "$1"
else
    # let's check for stuff in our working directory.
    pushd $wd > /dev/null

    # does our working dir have an .idea directory?
    if [ -d ".idea" ]; then
# echo "opening via the .idea dir"
      open -a "$CLion" .

    # is there an IDEA project file?
    elif [ -f *.ipr ]; then
# echo "opening via the project file"
      open -a "$CLion" `ls -1d *.ipr | head -n1`

    # Is there a pom.xml?
    elif [ -f Cargo.toml ]; then
# echo "importing from pom"
      open -a "$CLion" "Cargo.toml"

    # can't do anything smart; just open IDEA
    else
# echo 'cbf'
      open "$CLion"
    fi 
    popd > /dev/null
fi
