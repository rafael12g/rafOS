<div align="center">

# 🖥️ CustomOS

### A Minimal x86 Operating System Built From Scratch

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Build Status](https://img.shields.io/badge/build-passing-brightgreen)](https://github.com/yourusername/CustomOS)
[![Platform](https://img.shields.io/badge/platform-x86-blue)](https://en.wikipedia.org/wiki/X86)
[![Language](https://img.shields.io/badge/language-C%20%7C%20Assembly-orange)](https://github.com/yourusername/CustomOS)
[![Version](https://img.shields.io/badge/version-0.1.0-blue)](https://github.com/yourusername/CustomOS/releases)

**[Features](#-features) • [Getting Started](#-getting-started) • [Documentation](#-how-it-works) • [Roadmap](#-roadmap) • [Contributing](#-contributing)**

<img src="https://img.shields.io/badge/Status-In%20Development-orange" alt="Status">

---

### 📸 Demo
┌─────────────────────────────────────────────┐
│  CustomOS v0.1.0 - Educational OS Project   │
│  ─────────────────────────────────────────  │
│                                             │
│  > Kernel loaded successfully!              │
│  > Initializing drivers...                  │
│  > Screen driver: OK                        │
│  > Keyboard driver: OK                      │
│  > Timer driver: OK                         │
│                                             │
│  Welcome to CustomOS!                       │
│  Type 'help' for available commands         │
│                                             │
│  > _                                        │
└─────────────────────────────────────────────┘

</div>

---

## 📋 Table of Contents

- [About](#-about-this-project)
- [Features](#-features)
- [Architecture](#-architecture)
- [Getting Started](#-getting-started)
- [Project Structure](#-project-structure)
- [How It Works](#-how-it-works)
- [Development](#-development)
- [Roadmap](#-roadmap)
- [Contributing](#-contributing)
- [Resources](#-learning-resources)
- [License](#-license)

---

## 🎯 About This Project

**CustomOS** is an educational operating system project designed to understand the inner workings of OS development from the ground up. This project covers everything from bootloader development to kernel implementation, driver creation, and system programming.

### 🎓 Why This Project?

> *"I hear and I forget. I see and I remember. I do and I understand."* - Confucius

Building an OS from scratch is the ultimate way to understand:
- **How computers boot** and initialize hardware
- **How operating systems manage** memory, processes, and devices
- **Low-level programming** in Assembly and C
- **System architecture** and hardware interaction

### ⚠️ Important Disclaimer

This is a **learning project** and is **NOT intended for production use**. The code is experimental and may contain bugs, security vulnerabilities, and incomplete features. Use at your own risk!

---

## ✨ Features

### 🎉 Current Features (v0.1.0)

#### Bootloader
- ✅ **Custom 16-bit bootloader** written in x86 Assembly
- ✅ **Real mode to Protected mode** transition
- ✅ **Kernel loading** from disk into memory
- ✅ **A20 line enabling** for full memory access

#### Kernel Core
- ✅ **32-bit protected mode kernel** written in C
- ✅ **Global Descriptor Table (GDT)** setup
- ✅ **Interrupt Descriptor Table (IDT)** configuration
- ✅ **Interrupt Service Routines (ISRs)** for CPU exceptions
- ✅ **Hardware Interrupt Requests (IRQs)** handling

#### Drivers & Hardware
- ✅ **VGA Text Mode Driver** (80x25 color text output)
  - Color support (16 colors)
  - Scrolling support
  - Cursor management
- ✅ **PS/2 Keyboard Driver**
  - Basic US QWERTY layout
  - Shift key support
  - Special keys handling
- ✅ **PIT Timer Driver**
  - Configurable tick rate (default 100Hz)
  - System uptime tracking
- ✅ **I/O Port Operations** (inb/outb)

#### Standard Library (libc)
- ✅ **String operations** (strlen, strcmp, strcpy, etc.)
- ✅ **Memory operations** (memcpy, memset, memcmp)
- ✅ **Number conversion** (itoa, hex conversion)

### 🚧 In Progress

- 🔨 **Physical Memory Manager** (bitmap-based)
- 🔨 **Virtual Memory** (paging support)
- 🔨 **Heap Allocator** (kmalloc/kfree)

### 📅 Planned Features

- 📋 **System Calls** (syscall interface)
- 📋 **User Mode** programs
- 📋 **Process Management** (multitasking)
- 📋 **File System** (FAT12/FAT16 or custom)
- 📋 **Shell/CLI** (command interpreter)
- 📋 **ATA/IDE Disk Driver**
- 📋 **Network Stack** (basic TCP/IP)

---

## 🏛️ Architecture

### System Overview
┌─────────────────────────────────────────────────┐
│                  User Space                     │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐     │
│  │  Shell   │  │ Programs │  │   Apps   │     │
│  └──────────┘  └──────────┘  └──────────┘     │
├─────────────────────────────────────────────────┤
│              System Calls Layer                 │
├─────────────────────────────────────────────────┤
│                 Kernel Space                    │
│  ┌──────────────────────────────────────────┐  │
│  │         Process Manager (TODO)           │  │
│  ├──────────────────────────────────────────┤  │
│  │      Memory Manager (In Progress)        │  │
│  ├──────────────────────────────────────────┤  │
│  │          File System (TODO)              │  │
│  ├──────────────────────────────────────────┤  │
│  │            Device Drivers                │  │
│  │  ┌────────┐ ┌─────────┐ ┌──────────┐    │  │
│  │  │ Screen │ │Keyboard │ │  Timer   │    │  │
│  │  └────────┘ └─────────┘ └──────────┘    │  │
│  ├──────────────────────────────────────────┤  │
│  │      Interrupt & Exception Handling      │  │
│  │         (IDT, ISRs, IRQs)                │  │
│  ├──────────────────────────────────────────┤  │
│  │             Hardware Layer               │  │
│  │           (GDT, CPU, Memory)             │  │
│  └──────────────────────────────────────────┘  │
├─────────────────────────────────────────────────┤
│                  Bootloader                     │
│        (Real Mode → Protected Mode)             │
└─────────────────────────────────────────────────┘

### Memory Map
0x00000000 - 0x000003FF : Interrupt Vector Table (Real Mode)
0x00000400 - 0x000004FF : BIOS Data Area
0x00000500 - 0x00007BFF : Free conventional memory
0x00007C00 - 0x00007DFF : Bootloader (512 bytes)
0x00007E00 - 0x0009FFFF : Free conventional memory
0x000A0000 - 0x000BFFFF : Video memory
0x000C0000 - 0x000FFFFF : BIOS ROM
0x00100000 - 0x???????? : Kernel (loaded here by bootloader)

---

## 🚀 Getting Started

### Prerequisites

#### Required Tools

| Tool | Version | Purpose |
|------|---------|---------|
| **NASM** | 2.14+ | Assembler for bootloader and kernel entry |
| **GCC** | 9.0+ | C compiler for kernel |
| **LD** | 2.34+ | Linker (part of binutils) |
| **Make** | 4.0+ | Build automation |
| **QEMU** | 4.0+ | x86 emulator for testing |

#### Installation

**🐧 Debian/Ubuntu Linux:**

```bash
sudo apt update
sudo apt install -y build-essential nasm qemu-system-x86 binutils
Verify installation:
nasm --version    # Should show 2.14 or higher
gcc --version     # Should show 9.0 or higher
qemu-system-i386 --version
🍎 macOS:
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install dependencies
brew install nasm qemu gcc make

# Verify installation
nasm --version
gcc --version
qemu-system-i386 --version
🪟 Windows (WSL2 Recommended):
# Install WSL2 with Ubuntu
wsl --install -d Ubuntu

# Inside WSL2, follow Linux instructions
sudo apt update
sudo apt install -y build-essential nasm qemu-system-x86 binutils

Building
# Clone the repository
git clone https://github.com/yourusername/CustomOS.git
cd CustomOS

# Build everything
make all

# Or build specific components
make bootloader  # Build only bootloader
make kernel      # Build only kernel
Build Output:
Building bootloader...
  NASM    boot/boot.asm
  -> boot/boot.bin (512 bytes)

Building kernel...
  GCC     kernel/kernel.c
  GCC     drivers/screen.c
  GCC     drivers/keyboard.c
  ASM     kernel/kernel_entry.asm
  LD      kernel.bin

Creating OS image...
  -> os-image.bin (Ready to boot!)

Build successful! 🎉

Running
Quick Start
# Run in QEMU (default)
make run
Advanced Options
# Run with debugging symbols
make debug

# Run with GDB attached
make debug-gdb
# In another terminal:
gdb -ex "target remote localhost:1234" -ex "symbol-file kernel.elf"

# Create bootable ISO
make iso

# Clean build artifacts
make clean
QEMU Shortcuts



Key
Action



Ctrl+Alt+G
Release mouse grab


Ctrl+Alt+F
Toggle fullscreen


Ctrl+Alt+2
Switch to QEMU monitor


Ctrl+Alt+1
Switch back to OS


Ctrl+C (in terminal)
Quit QEMU



📁 Project Structure
CustomOS/
│
├── 📂 boot/                    # Bootloader (Stage 1)
│   ├── boot.asm               # Main bootloader code
│   └── boot.bin               # Compiled bootloader (512 bytes)
│
├── 📂 kernel/                  # Kernel core
│   ├── kernel.c               # Kernel entry point (kmain)
│   ├── kernel_entry.asm       # Low-level kernel entry (Assembly)
│   └── kernel.bin             # Compiled kernel binary
│
├── 📂 drivers/                 # Hardware drivers
│   ├── screen.c/h             # VGA text mode driver
│   ├── keyboard.c/h           # PS/2 keyboard driver
│   ├── ports.c/h              # I/O port operations
│   └── timer.c/h              # PIT timer driver
│
├── 📂 cpu/                     # CPU-related code
│   ├── gdt.c/h                # Global Descriptor Table
│   ├── idt.c/h                # Interrupt Descriptor Table
│   ├── isr.c/h/asm            # Interrupt Service Routines
│   └── timer.c/h              # Timer interrupt handler
│
├── 📂 libc/                    # Standard library implementation
│   ├── string.c/h             # String functions (strlen, strcmp, etc.)
│   ├── mem.c/h                # Memory functions (memcpy, memset, etc.)
│   └── stdio.c/h              # Basic I/O (future)
│
├── 📂 include/                 # Header files
│   ├── kernel.h               # Kernel definitions
│   ├── types.h                # Type definitions (uint32_t, etc.)
│   └── ...
│
├── 📄 Makefile                # Build system
├── 📄 linker.ld               # Linker script
├── 📄 README.md               # This file
├── 📄 LICENSE                 # MIT License
└── 📄 .gitignore              # Git ignore rules

🔧 How It Works
Boot Process
┌─────────────────────┐
│  1. BIOS Power-On   │
│     Self-Test       │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│  2. BIOS loads      │
│     bootloader      │
│     (boot.asm)      │
│     to 0x7C00       │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│  3. Bootloader      │
│     - Enables A20   │
│     - Loads GDT     │
│     - Enters PM     │
│     - Loads kernel  │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│  4. Kernel Entry    │
│     (kernel_entry)  │
│     - Sets up stack │
│     - Calls kmain() │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│  5. Kernel Init     │
│     (kernel.c)      │
│     - Init IDT      │
│     - Init drivers  │
│     - Main loop     │
└─────────────────────┘
Kernel Initialization Flow
void kmain(void) {
    // 1. Clear screen
    clear_screen();
    print("CustomOS v0.1.0 booting...\n");

    // 2. Initialize GDT
    print("Initializing GDT... ");
    gdt_init();
    print("[OK]\n");

    // 3. Initialize IDT
    print("Initializing IDT... ");
    idt_init();
    print("[OK]\n");

    // 4. Initialize ISRs (exceptions)
    print("Installing ISRs... ");
    isr_install();
    print("[OK]\n");

    // 5. Remap PIC
    print("Remapping PIC... ");
    irq_remap();
    print("[OK]\n");

    // 6. Initialize drivers
    print("Initializing drivers:\n");
    print("  - Timer driver... ");
    timer_init(100); // 100 Hz
    print("[OK]\n");
    
    print("  - Keyboard driver... ");
    keyboard_init();
    print("[OK]\n");

    // 7. Enable interrupts
    print("Enabling interrupts... ");
    asm volatile("sti");
    print("[OK]\n");

    // 8. Welcome message
    print("\nWelcome to CustomOS!\n");
    print("Type something on the keyboard...\n\n");

    // 9. Main kernel loop
    while (1) {
        asm volatile("hlt"); // Halt until next interrupt
    }
}

🛠️ Development
Building Individual Components
# Build only bootloader
make bootloader

# Build only kernel
make kernel

# Clean build artifacts
make clean

# Rebuild everything
make rebuild
Debugging with GDB
# Terminal 1: Start QEMU with GDB server
make debug-gdb

# Terminal 2: Connect GDB
gdb kernel.elf
(gdb) target remote localhost:1234
(gdb) break kmain
(gdb) continue
(gdb) backtrace
(gdb) info registers
(gdb) x/10x 0xB8000  # Examine video memory
Coding Style
// Use 4 spaces for indentation (no tabs)
void example_function(int param) {
    if (param > 0) {
        // Code here
    }
}

// Function naming: lowercase_with_underscores
void init_driver(void);

// Constants: UPPERCASE_WITH_UNDERSCORES
#define MAX_BUFFER_SIZE 256

// Types: lowercase_t suffix
typedef unsigned int uint32_t;

🗺️ Roadmap
📍 Phase 1: Foundation ✅ (v0.1.0 - Current)

 Bootloader (real mode → protected mode)
 Basic kernel (C entry point)
 GDT/IDT setup
 VGA text mode driver
 Keyboard input
 Timer interrupts
 Standard library basics

📍 Phase 2: Memory Management 🚧 (v0.2.0 - In Progress)

 Physical memory manager (bitmap)
 Virtual memory (paging)
 Kernel heap allocator (kmalloc/kfree)
 Memory protection

📍 Phase 3: User Space 📋 (v0.3.0 - Planned)

 System call interface
 User mode programs
 Process management (basic)
 Context switching

📍 Phase 4: File System 📋 (v0.4.0 - Planned)

 Virtual File System (VFS)
 ATA/IDE disk driver
 FAT12/16 support
 Basic file operations

📍 Phase 5: Shell & CLI 📋 (v0.5.0 - Future)

 Command interpreter
 Basic commands (ls, cat, echo, etc.)
 Pipe support

📍 Phase 6: Advanced Features 🔮 (v1.0.0 - Long-term)

 Multitasking (scheduler)
 Inter-process communication
 Network stack (TCP/IP)
 GUI framework


🤝 Contributing
Contributions are welcome! This is primarily a learning project, but if you have suggestions, bug fixes, or improvements, feel free to contribute.
How to Contribute

Fork the repository
Create a feature branch (git checkout -b feature/amazing-feature)
Commit your changes (git commit -m 'Add some amazing feature')
Push to the branch (git push origin feature/amazing-feature)
Open a Pull Request

Contribution Guidelines

✅ Follow the existing code style
✅ Comment your code clearly
✅ Test your changes in QEMU
✅ Update documentation if needed
✅ Keep commits atomic and descriptive

Areas Where Help Is Appreciated

🐛 Bug reports and fixes
📚 Documentation improvements
🧪 Testing on different hardware
💡 Feature suggestions
🎨 Code optimization


📚 Learning Resources
Books

Operating Systems: Three Easy Pieces (Free online)
Modern Operating Systems - Andrew S. Tanenbaum
Operating System Concepts - Silberschatz, Galvin, Gagne

Online Tutorials

🌐 OSDev Wiki - Essential reference
📘 Writing a Simple Operating System from Scratch by Nick Blundell
🎓 Bran's Kernel Development Tutorial

Documentation

📖 Intel x86 Software Developer Manuals
📖 NASM Documentation
📖 QEMU Documentation


🐛 Known Issues & Limitations
Current Limitations

⚠️ Architecture: x86 only (no x64 support yet)
⚠️ Memory: Static allocation only (no dynamic memory)
⚠️ Keyboard: US QWERTY layout only
⚠️ Display: VGA text mode only (80x25)
⚠️ Single-tasking: No multitasking yet
⚠️ No protection: Kernel mode only

Known Bugs

Keyboard buffer overflow: Typing too fast may lose keystrokes
Screen scrolling: Slight visual glitch when scrolling
Timer: Accuracy depends on emulator/hardware


📝 License
This project is licensed under the MIT License.
MIT License

Copyright (c) 2024 [Your Name]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

🙏 Acknowledgments
Inspiration

Linus Torvalds for creating Linux
Andrew S. Tanenbaum for MINIX
OSDev Community for invaluable resources

Tools

QEMU - The amazing emulator
NASM - The netwide assembler
GCC - GNU Compiler Collection


<div align="center">

Made with ❤️ and lots of ☕
Happy OS Development! 🚀

"The only way to learn a new programming language is by writing programs in it."— Dennis Ritchie

⬆️ Back to Top
</div>
```
