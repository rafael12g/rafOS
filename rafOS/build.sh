#!/bin/bash
nasm -f bin boot.asm -o boot.bin
nasm -f bin kernel.asm -o kernel.bin
dd if=/dev/zero of=rafos.img bs=512 count=2880 2>/dev/null
dd if=boot.bin of=rafos.img conv=notrunc 2>/dev/null
dd if=kernel.bin of=rafos.img seek=1 conv=notrunc 2>/dev/null
echo "✅ Build done!"
