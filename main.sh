# Clone Upstream
git clone https://gitlab.com/asus-linux/supergfxctl -b 5.1.2
cp -rvf ./debian ./supergfxctl
cd ./supergfxctl

# Get build deps
apt-get build-dep ./ -y

# Build package
LOGNAME=root dh_make --createorig -y -l -p supergfxctl_5.1.2
dpkg-buildpackage

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
