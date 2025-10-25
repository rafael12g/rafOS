# 🖥️ CustomOS - A Learning Journey into Operating System Development

> **A minimal x86 operating system built from scratch for educational purposes**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Made with Assembly](https://img.shields.io/badge/Made%20with-Assembly-red.svg)](https://en.wikipedia.org/wiki/X86_assembly_language)
[![Made with C](https://img.shields.io/badge/Made%20with-C-blue.svg)](https://en.wikipedia.org/wiki/C_(programming_language))

---

## 📖 About This Project

**CustomOS** is a personal learning project aimed at understanding how operating systems work at the lowest level. This is **not intended for production use** — it's purely educational.

### 🎯 Goals

- Learn x86 assembly and low-level programming
- Understand bootloaders, kernels, and hardware interaction
- Build a minimal OS with basic functionality (memory management, screen output, keyboard input)
- Document the journey for others who want to learn

### ⚠️ Disclaimer

This is a **hobby project** created for learning purposes. The code is experimental and may contain bugs or security issues. Use at your own risk!

---

## 🏗️ Project Structure
rafOS/
├── boot/               # Bootloader (Assembly)
│   └── boot.asm       # 512-byte bootloader
├── kernel/            # Kernel core (C)
│   ├── kernel.c       # Main kernel logic
│   └── kernel_entry.asm
├── drivers/           # Hardware drivers
│   ├── screen.c       # VGA text mode driver
│   ├── keyboard.c     # PS/2 keyboard driver
│   └── ports.c        # I/O port operations
├── cpu/               # CPU-related code
│   ├── idt.c          # Interrupt Descriptor Table
│   ├── isr.c          # Interrupt Service Routines
│   └── timer.c        # PIT timer driver
├── libc/              # Standard library functions
│   ├── string.c       # String operations
│   └── mem.c          # Memory operations
├── include/           # Header files
│   └── *.h
├── Makefile           # Build system
└── README.md          # This file


---

## 🚀 Getting Started

### Prerequisites

You need the following tools installed:

#### On Linux/Debian/Ubuntu:
```bash
sudo apt update
sudo apt install -y nasm gcc make qemu-system-x86 binutils

```

#ON MAC OS

brew install nasm qemu gcc make

---

Building the OS
# Clone the repository
git clone https://github.com/yourusername/CustomOS.git
cd CustomOS

# Build the OS image
make

# Run in QEMU emulator
make run

# Clean build artifacts
make clean


