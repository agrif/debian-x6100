#!/bin/sh
# The Standard System Utilities task that one sees in debian-installer
# consist of packages with priority 'required', 'important' and 'standard'.

# Install packages with priority 'required'
apt-get install $(awk '/^Package:/ { p = $2 }; /^Priority: required/ { print p }' /var/lib/dpkg/available)
# Install packages with priority 'important'
apt-get install $(awk '/^Package:/ { p = $2 }; /^Priority: important/ { print p }' /var/lib/dpkg/available)
# Install packages with priority 'standard'
apt-get install $(awk '/^Package:/ { p = $2 }; /^Priority: standard/ { print p }' /var/lib/dpkg/available)
