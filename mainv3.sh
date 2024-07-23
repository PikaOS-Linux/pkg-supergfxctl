#! /bin/bash

set -e

VERSION="5.2.3.git"

export DEBIAN_FRONTEND="noninteractive"
export DEB_BUILD_MAINT_OPTIONS="optimize=+lto -march=x86-64-v3 -O3 -flto -fuse-linker-plugin -falign-functions=32"
export DEB_CFLAGS_MAINT_APPEND="-march=x86-64-v3 -O3 -flto -fuse-linker-plugin -falign-functions=32"
export DEB_CPPFLAGS_MAINT_APPEND="-march=x86-64-v3 -O3 -flto -fuse-linker-plugin -falign-functions=32"
export DEB_CXXFLAGS_MAINT_APPEND="-march=x86-64-v3 -O3 -flto -fuse-linker-plugin -falign-functions=32"
export DEB_LDFLAGS_MAINT_APPEND="-march=x86-64-v3 -O3 -flto -fuse-linker-plugin -falign-functions=32"
export DEB_BUILD_OPTIONS="nocheck notest terse"
export DPKG_GENSYMBOLS_CHECK_LEVEL=0

# Clone Upstream
#git clone https://gitlab.com/asus-linux/supergfxctl -b "$VERSION"
git clone https://gitlab.com/asus-linux/supergfxctl
cp -rvf ./debian ./supergfxctl
mkdir ./supergfxctl/.cargo
cp -vf ./cargo-config-v3.toml ./supergfxctl/.cargo/config.toml
cd ./supergfxctl

# Get build deps
apt-get build-dep ./ -y

# Build package
LOGNAME=root dh_make --createorig -y -l -p supergfxctl_"$VERSION" || echo "dh-make: Ignoring Last Error"
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
