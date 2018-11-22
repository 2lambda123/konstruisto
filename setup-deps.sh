#!/bin/sh

# This script setups deps for Linux systems.

EXT="./ext/"
BUILD_TYPE="linux"
#BUILD_TYPE="windows"

echo "Setting up Konstruisto dependencies for $BUILD_TYPE..."
echo "Dependencies directory: $EXT"

# 1. Create directory
mkdir -p "$EXT"

# 2. Install packages
sudo apt-get install clang clang-format libglew-dev libglfw3-dev premake4 windres

# 3. Download GLM
wget https://github.com/g-truc/glm/releases/download/0.9.8.4/glm-0.9.8.4.zip --no-check-certificate -O glm-0.9.8.4.zip &&
unzip glm-0.9.8.4.zip -d "$EXT" &&
rm glm-0.9.8.4.zip

# 4. Download cereal
wget https://github.com/USCiLab/cereal/archive/v1.2.2.zip --no-check-certificate -O cereal-1.2.2.zip &&
unzip cereal-1.2.2.zip -d "$EXT" &&
rm cereal-1.2.2.zip

# 5. Download stb_image
mkdir -p "$EXT/stb/stb/" &&
wget https://raw.githubusercontent.com/nothings/stb/master/stb_image.h --no-check-certificate -P "$EXT/stb/stb/"

# 6. Download and build NanoVG
git clone git@github.com:memononen/nanovg.git "$EXT/nanovg" &&
cd "$EXT/nanovg" &&
premake4 --cc=gcc gmake &&
mv "build/" "build-$BUILD_TYPE/" &&
cd "build-$BUILD_TYPE/" &&
make config=release64 nanovg

# Google Test
# wget https://github.com/google/googletest/archive/release-1.8.0.zip --no-check-certificate && unzip release-1.8.0 -d "$EXT" && rm release-1.8.0
# mkdir -p "$EXT/googletest-release-1.8.0/googletest/lib/" &&
# cd "$EXT/googletest-release-1.8.0/googletest/lib/"
# clang++ -isystem ../include -I../ -pthread -c "../src/gtest-all.cc"
# ar -rv libgtest.a gtest-all.o
# cd -

# Others
echo "Done."
