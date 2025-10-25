# 🖥️ CustomOS

**A minimal x86 operating system built from scratch for educational purposes**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-x86-blue.svg)](.)
[![Language](https://img.shields.io/badge/language-C%20%7C%20Assembly-orange.svg)](.)
[![Version](https://img.shields.io/badge/version-0.1.0-blue.svg)](.)

> **"If you want to truly understand how computers work, build your own operating system."**
> 
> This project is my journey into the depths of systems programming. Feel free to learn from it, modify it, and make it your own. All I ask is that you share your knowledge with others as freely as it was shared with you.

---

## 📖 About

CustomOS is an educational operating system written from scratch in x86 Assembly and C. This project exists to demystify operating system development and provide a hands-on learning resource for anyone curious about how computers really work at the lowest level.

**This is a learning project.** It's not meant for production use. The goal is to understand OS fundamentals: bootloaders, protected mode, interrupts, drivers, and kernel development.

---

## ✨ Features

**Boot System:**
- Custom 16-bit bootloader (512 bytes)
- Disk reading via BIOS interrupts
- Protected mode transition
- Kernel loading from disk

**Kernel Core:**
- 32-bit protected mode kernel in C
- Global Descriptor Table (GDT) setup
- Interrupt Descriptor Table (IDT) implementation
- CPU exception handlers (32 ISRs)
- Hardware interrupt handling (16 IRQs)
- PIC remapping and configuration

**Hardware Drivers:**
- VGA text mode driver (80x25, 16 colors)
- PS/2 keyboard driver (US QWERTY layout)
- PIT timer driver (configurable frequency)

**Standard Library:**
- String functions (strlen, strcmp, strcpy, strcat)
- Memory functions (memcpy, memset, memcmp)
- Number conversion (itoa, hex conversion)
- Port I/O operations (inb, outb)

---

## 🚀 Getting Started

### Prerequisites

You need these tools installed:

```bash
# On Ubuntu/Debian
sudo apt-get update
sudo apt-get install nasm gcc qemu-system-x86 make

# On macOS
brew install nasm i686-elf-gcc qemu make

# On Arch Linux
sudo pacman -S nasm gcc qemu make

```
#Building and Running

# Clone the repository
git clone https://github.com/yourusername/CustomOS.git
cd CustomOS

# Build the OS
make

# Run in QEMU
make run

# Clean build files
make clean


That's it! You should see CustomOS booting in QEMU. (if i'm lucky)


##📁 Project Structure

rafOS/
├── boot/
│   ├── boot_sect.asm      # 16-bit bootloader (stage 1)
│   └── kernel_entry.asm   # Kernel entry point (assembly)
├── kernel/
│   ├── kernel.c           # Main kernel code
│   ├── kernel.h           # Kernel headers
│   ├── low_level.c        # Low-level utilities (port I/O)
│   ├── low_level.h
│   └── util.c             # Standard library functions
├── drivers/
│   ├── screen.c           # VGA text mode driver
│   ├── screen.h
│   ├── keyboard.c         # PS/2 keyboard driver
│   ├── keyboard.h
│   ├── timer.c            # PIT timer driver
│   └── timer.h
├── cpu/
│   ├── gdt.c              # Global Descriptor Table
│   ├── gdt.h
│   ├── idt.c              # Interrupt Descriptor Table
│   ├── idt.h
│   ├── isr.c              # Interrupt Service Routines
│   ├── isr.h
│   ├── interrupt.asm      # Low-level interrupt handlers
│   ├── timer.c
│   └── timer.h
├── Makefile               # Build system
├── README.md              # This file
└── LICENSE                # MIT License


---


🔧 How It Works
Boot Process

BIOS Stage: Computer powers on, BIOS loads first 512 bytes (bootloader) from disk to 0x7C00
Bootloader Stage: 
Loads kernel from disk sectors to memory at 0x1000
Enables A20 gate for >1MB memory access
Sets up GDT and switches to 32-bit protected mode
Jumps to kernel entry point


Kernel Stage:
Initializes GDT and IDT
Installs interrupt handlers (ISRs and IRQs)
Initializes hardware drivers (screen, keyboard, timer)
Enters main kernel loop



Memory Map
