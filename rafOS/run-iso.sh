#!/bin/bash
# Run RafOS from ISO in QEMU

if [ ! -f "rafos.iso" ]; then
    echo "❌ Error: rafos.iso not found!"
    echo "Run ./build-iso.sh first to create the ISO"
    exit 1
fi

echo "🚀 Launching RafOS from ISO..."
echo ""
echo "Press Ctrl+Alt+G to release mouse capture"
echo "Press Ctrl+Alt+F to toggle fullscreen"
echo "Press Ctrl+Alt+Q to quit QEMU"
echo ""

qemu-system-i386 -cdrom rafos.iso -boot d
