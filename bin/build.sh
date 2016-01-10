#!/usr/bin/env bash
APP_NAME="EStrap"
SERVER_BIN="svx.bin"
EVERS="0.36.2"
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
appDir="$( cd -P "$( dirname "$SOURCE" )/../" && pwd )"

buildLinux(){
    echo "-> Building linux/amd64 server thread"
    mkdir -p build/$1/$2
    GOOS=linux GOARCH=amd64 go build -o build/linux/amd64/svx.bin .

    echo "-> Building linux/x86_64 application binary"
    if [ -f "$appDir/app/$SERVER_BIN" ]; then
        rm -f "$appDir/app/$SERVER_BIN"
    fi
    mv $appDir/build/linux/amd64/svx.bin $appDir/app/
    cd dist
    electron-packager $appDir/app $APP_NAME --platform=linux --arch=x64 --version=$EVERS
}

cd $appDir
echo "-->> Cleaning out build dir"
rm -rf build/
mkdir -p build
echo "-->> Cleaning out dist dir"
rm -rf dist/
mkdir -p dist
echo "-->> Installing dependencies"
npm update
echo "-->> Upgrading all modules"
npm update electron-packager
npm update electron-prebuilt

echo "--> Building server thread binaries"
cd $appDir
echo "--> Building Linux 64"
buildLinux
#buildServer linux 386
#buildServer windows amd64
#buildServer windows 386
#buildServer darwin 386
#buildServer darwin amd64

echo "--> Building the final binaries"
#electron-packager <sourcedir> <appname> --platform=<platform> --arch=<arch> --version=<Electron version> [optional flags...]
#electron-packager . FooBar --platform=darwin --arch=x64 --version=0.36.2