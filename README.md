# CustomOS

A minimal x86 operating system built from scratch for learning purposes.

## About

CustomOS is an educational OS written in x86 Assembly and C to understand how operating systems work at a low level.

## Features

- Custom bootloader
- 32-bit protected mode kernel
- VGA text mode driver
- PS/2 keyboard driver
- Timer and interrupt handling
- Basic standard library

## Requirements

- NASM (assembler)
- GCC (C compiler)
- QEMU (emulator)
- Make

## Installation

**Ubuntu/Debian:**
```bash
sudo apt install nasm gcc qemu-system-x86 make
macOS:
brew install nasm i686-elf-gcc qemu make
Build & Run
# Build the OS
make all

# Run in QEMU
make run

# Clean build files
make clean
Project Structure

```
CustomOS/
├── boot/           # Bootloader
├── kernel/         # Kernel code
├── drivers/        # VGA, keyboard, timer
├── cpu/            # GDT, IDT, interrupts
├── libc/           # Standard library
└── Makefile
How It Works

BIOS loads the bootloader
Bootloader switches to protected mode
Kernel initializes drivers
System enters main loop

Roadmap

 Bootloader
 Protected mode
 VGA driver
 Keyboard driver
 Memory management
 Shell
 File system

Resources

OSDev Wiki
Intel Manuals

License
MIT License - see LICENSE for details.
Contributing
Feel free to open issues or submit pull requests!

Made with ☕ and debugging
