#!/bin/bash

# Default values for architecture
DIRECTORY_ARCH="x64"  # Default directory name
BINARY_ARCH="x86_64"  # Default binary name
RPM_ARCH="x86_64"     # Default RPM architecture

# Parse command-line arguments
while getopts "d:b:" opt; do
  case $opt in
    d) DIRECTORY_ARCH="$OPTARG" ;;  # Set the directory architecture
    b) BINARY_ARCH="$OPTARG" ;;    # Set the binary architecture
    *) 
      echo "Usage: $0 [-d directory_arch] [-b binary_arch]"
      exit 1
      ;;
  esac
done
RPM_ARCH=$BINARY_ARCH

# Normalize architecture names for RPM
if [ "$RPM_ARCH" == "arm64" ]; then
  RPM_ARCH="aarch64"
fi
# Read version from pubspec
SETONIX_VERSION_REGEX="version:\s(.+)\+(.+)"
[[ $(grep -E "${SETONIX_VERSION_REGEX}" pubspec.yaml) =~ ${SETONIX_VERSION_REGEX} ]]
SETONIX_VERSION="${BASH_REMATCH[1]}"

# Replace - with ~ to match RPM versioning
RPM_VERSION=$(echo $SETONIX_VERSION | sed 's/-/~/g')
CURRENT_DIR=$(pwd)
echo "Building Setonix $RPM_VERSION for $DIRECTORY_ARCH/$BINARY_ARCH ($RPM_ARCH)"

# Clean and set up build directories
rm -rf build/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
mkdir -p build/{BUILD,RPMS,SOURCES,SPECS,SRPMS}

# Copy files
cp linux/rpm/linwood-setonix.spec build/SPECS/linwood-setonix.spec
cp -r build/linux/${DIRECTORY_ARCH}/release/bundle build/SOURCES/linwood-setonix-$RPM_VERSION
chmod 755 build/SOURCES/linwood-setonix-$RPM_VERSION/setonix
mv build/SOURCES/linwood-setonix-$RPM_VERSION/setonix build/SOURCES/linwood-setonix-$RPM_VERSION/linwood-setonix
cp linux/rpm/linwood-setonix.desktop build/SOURCES/linwood-setonix-$RPM_VERSION/linwood-setonix.desktop

# Update .spec file with the correct version
sed -i "2s/.*/Version: $RPM_VERSION/" build/SPECS/linwood-setonix.spec

# Create tarball
cd build/SOURCES/
# Fix .so files using patchelf
cd linwood-setonix-$RPM_VERSION/lib
for file in *.so; do
  PATCHELF_OUTPUT=$(patchelf --print-rpath "$file")
  echo "Checking $file: $PATCHELF_OUTPUT"
  # Skip file if PATCHELF_OUTPUT does not contain CURRENT_DIR
  if [[ ! $PATCHELF_OUTPUT =~ $CURRENT_DIR ]]; then
    echo "Skipping $file"
    continue
  fi
  echo "Fixing $file"
  patchelf --set-rpath '$ORIGIN' "$file"
done
cd ../../
tar --create --file linwood-setonix-$RPM_VERSION.tar.gz linwood-setonix-$RPM_VERSION
cd ../../

# Build RPM
QA_RPATHS=$[ 0x0001|0x0010 ] rpmbuild -bb build/SPECS/linwood-setonix.spec --define "_topdir $(pwd)/build"

# Copy the RPM to the build folder
cp build/RPMS/${RPM_ARCH}/linwood-setonix-*.rpm build/linwood-setonix-linux-${BINARY_ARCH}.rpm
