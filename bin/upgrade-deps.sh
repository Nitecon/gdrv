#!/usr/bin/env bash
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
appDir="$( cd -P "$( dirname "$SOURCE" )/../" && pwd )"
cd $appDir
echo "-->> All these commands require sudo, please enter sudo password"
sudo npm cache clean -f
sudo npm install -g n
sudo n stable
sudo npm install electron-packager -g