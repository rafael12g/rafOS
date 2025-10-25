# 🖥️ CustomOS

<div align="center">

**A minimal x86 operating system built from scratch for learning purposes**

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-x86-orange.svg)]()
[![Language](https://img.shields.io/badge/language-C%20%7C%20ASM-green.svg)]()

</div>

---

## 📖 About

CustomOS is an educational operating system written in **x86 Assembly** and **C**. 

This project is built from scratch to understand:
- How bootloaders work
- Protected mode and memory management
- Hardware interrupts and drivers
- Low-level programming

> **Note:** This is a personal learning project. Feel free to learn from it and contribute!

---

## ✨ Features

- ✅ Custom 16-bit bootloader
- ✅ 32-bit protected mode kernel
- ✅ VGA text mode driver (80x25, 16 colors)
- ✅ PS/2 keyboard driver
- ✅ PIT timer driver
- ✅ Interrupt handling (ISR/IRQ)
- ✅ Basic standard library

---

## 🚀 Quick Start

### Requirements

- **NASM** - Assembler
- **GCC** - C Compiler (i686-elf-gcc recommended)
- **QEMU** - x86 Emulator
- **Make** - Build tool

### Installation

**Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install nasm gcc qemu-system-x86 make
macOS:
brew install nasm i686-elf-gcc qemu make
Arch Linux:
sudo pacman -S nasm gcc qemu make
Build & Run
# Clone repository
git clone https://github.com/yourusername/CustomOS.git
cd CustomOS

# Build
make all

# Run in QEMU
make run

# Clean
make clean

📁 Project Structure
CustomOS/
│
├── boot/
│   └── boot_sect.asm          # Bootloader (16-bit real mode)
│
├── kernel/
│   ├── kernel.c               # Main kernel code
│   └── kernel_entry.asm       # Kernel entry point (32-bit)
│
├── drivers/
│   ├── screen.c               # VGA text driver
│   ├── keyboard.c             # Keyboard driver
│   └── timer.c                # Timer driver
│
├── cpu/
│   ├── gdt.c                  # Global Descriptor Table
│   ├── idt.c                  # Interrupt Descriptor Table
│   ├── isr.c                  # Interrupt Service Routines
│   └── timer.c                # PIT configuration
│
├── libc/
│   ├── string.c               # String utilities
│   └── mem.c                  # Memory utilities
│
└── Makefile                   # Build configuration

🔧 How It Works
Boot Process

BIOS loads the bootloader from disk sector 0
Bootloader (16-bit real mode):
Loads the kernel from disk
Sets up GDT (Global Descriptor Table)
Switches to 32-bit protected mode
Jumps to kernel


Kernel (32-bit protected mode):
Initializes IDT (Interrupt Descriptor Table)
Sets up hardware drivers (VGA, keyboard, timer)
Enters main event loop



Memory Map
0x00000000 - 0x000003FF    Real Mode IVT
0x00000400 - 0x000004FF    BIOS Data Area
0x00007C00 - 0x00007DFF    Bootloader (512 bytes)
0x00001000 - 0x0009FFFF    Kernel Code & Data
0x000A0000 - 0x000BFFFF    Video Memory
0x000B8000 - 0x000B8FA0    VGA Text Buffer (80x25)
0x00100000+                Extended Memory
Interrupt Handling

ISR 0-31: CPU exceptions (divide by zero, page fault, etc.)
IRQ 0: Timer (PIT at 18.222 Hz)
IRQ 1: Keyboard (PS/2)
IRQ 2-15: Other hardware interrupts


🎯 Roadmap
Completed:

 Bootloader and protected mode
 VGA driver
 Keyboard driver
 Timer driver
 Basic interrupt handling

In Progress:

 Memory management (paging)
 Shell with basic commands

Future:

 File system (FAT12)
 Process management
 Multitasking scheduler
 User mode


📚 Resources
Here are the resources that helped me build this OS:

OSDev Wiki - Comprehensive OS development resource
Intel x86 Manuals - Official CPU documentation
Bran's Kernel Development Tutorial - Beginner-friendly guide
JamesM's Kernel Tutorial - Another great tutorial


🤝 Contributing
Contributions are welcome! This is a learning project, so:

🐛 Bug reports are appreciated
💡 Feature suggestions are welcome
🔧 Pull requests should be well-documented
📖 Documentation improvements are always helpful

Please open an issue before making major changes.

📄 License
This project is licensed under the MIT License - see the LICENSE file for details.

🙏 Acknowledgments
Thanks to the OSDev community for their incredible documentation and support.

<div align="center">

Made with ☕ and lots of debugging
⭐ Star this repo if you find it helpful!
</div>
```
