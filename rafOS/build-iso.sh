#!/bin/bash

echo "🔨 Building RafOS..."
./build.sh

if [ ! -f "rafos.img" ]; then
    echo "❌ Error: rafos.img not found!"
    exit 1
fi

echo ""
echo "📀 Creating bootable ISO..."

# Create temporary directory structure for ISO
mkdir -p iso_build/boot

# Copy the floppy image to the boot directory
cp rafos.img iso_build/boot/rafos.img

# Create an ISO with El Torito boot specification
# The floppy image will be used as the boot image
xorriso -as mkisofs \
    -o rafos.iso \
    -b boot/rafos.img \
    -c boot/boot.cat \
    -no-emul-boot \
    -boot-load-size 4 \
    -boot-info-table \
    -R -J -V "RafOS_v2.0" \
    iso_build/

# Clean up
rm -rf iso_build

if [ -f "rafos.iso" ]; then
    echo "✅ ISO created successfully!"
    echo ""
    ls -lh rafos.iso
    echo ""
    echo "You can now use: qemu-system-i386 -cdrom rafos.iso"
    echo "Or burn it to a CD/DVD or mount it in a virtual machine"
else
    echo "❌ Failed to create ISO!"
    exit 1
fi
