#!/usr/bin/env python3
import os
import sys

def cmd(command, description):
    print(f"[*] {description}")
    result = os.system(command)
    if result != 0:
        print(f"❌ Error: {description} failed!")
        sys.exit(1)
    print(f"✅ {description} done!\n")

def clean():
    print("\n" + "="*50)
    print("[*] Cleaning RafOS")
    print("="*50)
    os.system("rm -f *.bin *.o boot/*.bin boot/*.o kernel/*.o drivers/*.o cpu/*.o libc/*.o browser/*.o")
    print("✅ Clean done!\n")

def build():
    print("\n" + "="*50)
    print("[*] Building RafOS with Browser")
    print("="*50 + "\n")
    
    # Compile bootloader
    cmd("nasm boot/boot_sect.asm -f bin -o boot/boot_sect.bin", "Compiling bootloader")
    cmd("nasm boot/kernel_entry.asm -f elf32 -o boot/kernel_entry.o", "Compiling kernel entry")
    
    # Compile C files
    cf = "-m32 -ffreestanding -fno-stack-protector -nostartfiles -nodefaultlibs -fno-pic -fno-pie -Wall -Wextra -Werror"
    
    cmd(f"gcc {cf} -c kernel/kernel.c -o kernel/kernel.o", "Compiling kernel.c")
    cmd(f"gcc {cf} -c drivers/screen.c -o drivers/screen.o", "Compiling screen.c")
    cmd(f"gcc {cf} -c drivers/keyboard.c -o drivers/keyboard.o", "Compiling keyboard.c")
    cmd(f"gcc {cf} -c cpu/ports.c -o cpu/ports.o", "Compiling ports.c")
    cmd(f"gcc {cf} -c libc/string.c -o libc/string.o", "Compiling string.c")
    cmd(f"gcc {cf} -c browser/browser.c -o browser/browser.o", "Compiling browser.c")
    
    # Link
    lf = "-m elf_i386 -Ttext 0x1000 --oformat binary"
    obj = "boot/kernel_entry.o kernel/kernel.o drivers/screen.o drivers/keyboard.o cpu/ports.o libc/string.o browser/browser.o"
    cmd(f"ld {lf} -o kernel.bin {obj}", "Linking kernel")
    
    # Create OS image
    cmd("cat boot/boot_sect.bin kernel.bin > os-image.bin", "Creating OS image")
    
    size = os.path.getsize('os-image.bin')
    print(f"\n✅ RafOS built successfully! Size: {size} bytes")

def run():
    if not os.path.exists("os-image.bin"):
        print("❌ Error: os-image.bin not found. Run './build.py' first.")
        sys.exit(1)
    print("\n🌐 Launching RafOS with Browser in QEMU...")
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

