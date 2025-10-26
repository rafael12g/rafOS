#!/usr/bin/env python3
import os
import subprocess
import sys

def cmd(command, description):
    print(f"\n{'='*50}")
    print(f"[*] {description}")
    print(f"{'='*50}")
    result = subprocess.run(command, shell=True, capture_output=True, text=True)
    if result.returncode != 0:
        print(f"❌ ERROR: {description} failed!")
        print(result.stderr)
        sys.exit(1)
    if result.stdout:
        print(result.stdout)
    print(f"✅ {description} done!")

def clean():
    print("\n🧹 Cleaning RafOS...")
    cmd("rm -f *.bin *.o boot/*.bin boot/*.o kernel/*.o drivers/*.o cpu/*.o libc/*.o", "Clean")

def build():
    print("\n🔨 Building RafOS...")
    
    # Bootloader
    cmd("nasm boot/boot_sect.asm -f bin -o boot/boot_sect.bin", "Compiling bootloader")
    cmd("nasm boot/kernel_entry.asm -f elf -o boot/kernel_entry.o", "Compiling kernel entry")
    
    # C flags
    cf = "-g -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -fno-pic -fno-pie -Wall -Wextra -Werror"
    
    # Compile C files
    cmd(f"gcc {cf} -c kernel/kernel.c -o kernel/kernel.o", "Compiling kernel.c")
    cmd(f"gcc {cf} -c drivers/screen.c -o drivers/screen.o", "Compiling screen.c")
    cmd(f"gcc {cf} -c drivers/keyboard.c -o drivers/keyboard.o", "Compiling keyboard.c")
    cmd(f"gcc {cf} -c cpu/ports.c -o cpu/ports.o", "Compiling ports.c")
    cmd(f"gcc {cf} -c libc/string.c -o libc/string.o", "Compiling string.c")
    
    # Link
    lf = "-m elf_i386 -Ttext 0x1000 --oformat binary"
    obj = "boot/kernel_entry.o kernel/kernel.o drivers/screen.o drivers/keyboard.o cpu/ports.o libc/string.o"
    cmd(f"ld {lf} -o kernel.bin {obj}", "Linking kernel")
    
    # Create OS image
    cmd("cat boot/boot_sect.bin kernel.bin > os-image.bin", "Creating OS image")
    
    size = os.path.getsize('os-image.bin')
    print(f"\n✅ RafOS built successfully! Size: {size} bytes")

def run():
    if not os.path.exists("os-image.bin"):
        print("❌ Error: os-image.bin not found. Run './build.py' first.")
        sys.exit(1)
    print("\n🚀 Launching RafOS in QEMU...")
    os.system("qemu-system-i386 -drive file=os-image.bin,format=raw,if=floppy -boot a")

if __name__ == "__main__":
    if len(sys.argv) > 1:
        if sys.argv[1] == "clean":
            clean()
        elif sys.argv[1] == "run":
            run()
        elif sys.argv[1] == "all":
            clean()
            build()
            run()
        else:
            print("Usage: ./build.py [clean|run|all]")
            sys.exit(1)
    else:
        clean()
        build()
        print("\n🚀 To run: ./build.py run")
        print("🚀 Or build and run: ./build.py all")

