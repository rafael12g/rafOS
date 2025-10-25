# 🖥️ CustomOS

> A minimal x86 operating system built from scratch for learning purposes

<div align="center">

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-x86-orange.svg)]()
[![Made with](https://img.shields.io/badge/made%20with-C%20%7C%20ASM-green.svg)]()
[![Lines of Code](https://img.shields.io/badge/lines%20of%20code-2000%2B-brightgreen.svg)]()
[![Build](https://img.shields.io/badge/build-passing-success.svg)]()

**[Features](#-features)** • **[Installation](#-installation)** • **[Quick Start](#-quick-start)** • **[Documentation](#-project-structure)** • **[Roadmap](#-roadmap)**

</div>

---

## 💡 About

CustomOS is an educational operating system written in **x86 Assembly** and **C** to understand how operating systems work at a low level.

<table>
<tr>
<td>

### 🎓 Learning Goals
- Bootloader development
- Protected mode programming
- Hardware driver implementation
- Interrupt handling
- Memory management basics

</td>
<td>

### 🔧 Tech Stack
- **Assembly:** NASM (x86)
- **Language:** C
- **Emulator:** QEMU
- **Build:** GNU Make
- **Debugger:** GDB

</td>
</tr>
</table>

> [!NOTE]
> **"If you want to truly understand computers, build your own OS."**
> 
> This project is my journey into systems programming. Feel free to learn from it and make it your own. All I ask is that you share your knowledge with others as freely as it was shared with you. 💜

---

## ✨ Features

<table>
<tr>
<td width="50%">

### 🚀 Core Features
- ✅ Custom 16-bit bootloader
- ✅ 32-bit protected mode kernel
- ✅ Global Descriptor Table (GDT)
- ✅ Interrupt Descriptor Table (IDT)
- ✅ Hardware interrupt handling (IRQ)
- ✅ Software interrupt handling (ISR)

</td>
<td width="50%">

### 🔌 Drivers & Libraries
- ✅ VGA text mode (80x25, 16 colors)
- ✅ PS/2 keyboard driver
- ✅ PIT timer driver (18.222 Hz)
- ✅ Basic libc (string, memory, I/O)
- ✅ Screen scrolling & cursor
- ✅ Color support

</td>
</tr>
</table>

---

## 🛠️ Requirements

| Tool | Version | Purpose |
|------|---------|---------|
| **NASM** | 2.14+ | x86 Assembly compiler |
| **GCC** | 7.0+ | C compiler (i686-elf recommended) |
| **QEMU** | 4.0+ | x86 system emulator |
| **Make** | 4.0+ | Build automation |
| **GDB** (optional) | 8.0+ | Debugging |

---

## 📦 Installation

<details>
<summary><b>🐧 Ubuntu/Debian</b></summary>

```bash
sudo apt update
sudo apt install nasm gcc qemu-system-x86 make binutils gdb
```
<details>
    
<summary><b>🍎 macOS</b></summary>
    
```bash
brew install nasm i686-elf-gcc qemu make i686-elf-gdb
</details>

<details>
<summary><b>🎯 Arch Linux</b></summary>

sudo pacman -S nasm gcc qemu make gdb
</details>

<details>
<summary><b>🪟 Windows (WSL)</b></summary>

# Enable WSL first, then:
sudo apt update
sudo apt install nasm gcc qemu-system-x86 make binutils gdb
</details>


🚀 Quick Start
# 1️⃣ Clone the repository
git clone https://github.com/yourusername/CustomOS.git
cd CustomOS

# 2️⃣ Build the OS
make all

# 3️⃣ Run in QEMU
make run

# 4️⃣ Debug (optional)
make debug

# 5️⃣ Clean build files
make clean
🎮 Keyboard Shortcuts in QEMU



Key
Action



Ctrl + Alt + G
Release mouse from QEMU


Ctrl + Alt + 1
Switch to monitor console


Ctrl + Alt + 2
Switch back to OS


Ctrl + A, X
Exit QEMU (text mode)



📁 Project Structure
CustomOS/
│
├── 🥾 boot/
│   └── boot_sect.asm          # 16-bit bootloader (512 bytes)
│
├── 🧠 kernel/
│   ├── kernel.c               # Main kernel code
│   ├── kernel_entry.asm       # Kernel entry point (32-bit)
│   └── util.c                 # Utility functions
│
├── 🔌 drivers/
│   ├── ports.h/.c             # I/O port operations
│   ├── screen.h/.c            # VGA text driver
│   ├── keyboard.h/.c          # PS/2 keyboard driver
│   └── timer.h/.c             # PIT timer driver
│
├── ⚡ cpu/
│   ├── gdt.h/.c/.asm          # Global Descriptor Table
│   ├── idt.h/.c/.asm          # Interrupt Descriptor Table
│   ├── isr.h/.c/.asm          # Interrupt Service Routines
│   └── timer.h/.c             # CPU timer setup
│
├── 📖 libc/
│   ├── mem.h/.c               # Memory operations (memcpy, memset)
│   ├── string.h/.c            # String operations (strlen, strcmp)
│   └── function.h             # Utility macros
│
├── 🔧 Makefile                # Build configuration
└── 📄 README.md               # This file

🔄 How It Works
┌─────────────────────────────────────────────────────────────┐
│                      BOOT SEQUENCE                          │
└─────────────────────────────────────────────────────────────┘

    1. 💾 BIOS → Loads bootloader from sector 0
           ↓
    2. 🥾 Bootloader (16-bit Real Mode)
           • Load kernel from disk
           • Switch to Protected Mode
           • Setup GDT
           ↓
    3. 🧠 Kernel Entry (32-bit Protected Mode)
           • Setup IDT
           • Initialize drivers
           • Enable interrupts
           ↓
    4. ⚙️ Main Loop
           • Handle keyboard input
           • Process timer ticks
           • Display output on VGA

🎯 Roadmap
✅ Phase 1: Boot & Protected Mode (Completed)

 Write bootloader
 Load kernel from disk
 Switch to 32-bit protected mode
 Setup GDT and segmentation

✅ Phase 2: Interrupts & Drivers (Completed)

 Implement IDT
 Handle ISRs (exceptions)
 Handle IRQs (hardware interrupts)
 VGA text driver
 Keyboard driver
 Timer driver

🔄 Phase 3: Memory Management (In Progress)

 Physical memory manager
 Virtual memory (paging)
 Heap allocator (malloc/free)
 Memory protection

📋 Phase 4: Shell & User Interface (Planned)

 Command interpreter
 Basic commands (help, clear, echo)
 Command history
 Tab completion

🚀 Phase 5: File System (Future)

 FAT12 implementation
 File operations (read, write, create, delete)
 Directory support
 Mount points

🎪 Phase 6: Multitasking (Future)

 Process control blocks
 Context switching
 Round-robin scheduler
 User mode


📚 Learning Resources
📖 Essential Reading

OSDev Wiki - The OS development bible
Intel x86 Manuals - Official CPU documentation
Bran's Kernel Tutorial - Beginner-friendly guide

🎥 Video Tutorials

Writing an OS - Detailed video series
OS Dev Series - Another great playlist

📘 Books

"Operating Systems: Design and Implementation" by Andrew S. Tanenbaum
"Modern Operating Systems" by Andrew S. Tanenbaum
"Operating System Concepts" by Silberschatz, Galvin, Gagne


🐛 Debugging
Using GDB with QEMU
# Terminal 1: Start QEMU in debug mode
make debug

# Terminal 2: Connect GDB
gdb kernel.elf
(gdb) target remote localhost:1234
(gdb) break kernel_main
(gdb) continue
Useful GDB Commands



Command
Description



break kernel_main
Set breakpoint


continue
Continue execution


step
Step into function


next
Step over function


info registers
Show register values


x/16x $esp
Examine stack



🤝 Contributing

[!TIP]
Contributions are welcome! Whether you're fixing bugs, adding features, or improving documentation.

How to Contribute

Fork the repository
Create a feature branch (git checkout -b feature/amazing-feature)
Commit your changes (git commit -m 'Add amazing feature')
Push to the branch (git push origin feature/amazing-feature)
Open a Pull Request

Contribution Ideas

🐛 Fix bugs
📝 Improve documentation
✨ Add new features
🧪 Write tests
🎨 Enhance UI/UX
🌍 Translate docs


📊 Stats
<div align="center">




Metric
Value



Lines of Code
~2000+


Files
25+


Bootloader Size
512 bytes


Kernel Size
~50 KB


Supported Resolution
80x25 text


Colors
16


</div>


📄 License
This project is licensed under the MIT License - see the LICENSE file for details.
MIT License

Copyright (c) 2024 [Your Name]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction...

🙏 Acknowledgments

💙 OSDev Community - For their amazing documentation
🎓 Bran Kernighan - For inspiring countless developers
🔥 Linus Torvalds - For showing us what's possible
☕ Coffee - For keeping me awake during debugging sessions


🌟 Star History
<div align="center">

<img src="https://api.star-history.com/svg?repos=yourusername/CustomOS&type=Date" alt="Star History Chart" />
</div>


<div align="center">

💻 Made with ☕ and lots of debugging
If this project helped you, consider giving it a ⭐!
⬆ Back to Top

Report Bug • Request Feature • Documentation
</div>
```
