# 🖥️ CustomOS

> A minimal x86 operating system built from scratch for learning purposes

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-x86-orange.svg)]()
[![Made with](https://img.shields.io/badge/made%20with-C%20%7C%20ASM-green.svg)]()

---

## 💡 About

CustomOS is an educational operating system written in **x86 Assembly** and **C** to understand how operating systems work at a low level.

> [!NOTE]
> **"If you want to truly understand computers, build your own OS."**
> 
> This project is my journey into systems programming. Feel free to learn from it and make it your own. All I ask is that you share your knowledge with others as freely as it was shared with you.

---

## ✨ Features

- 🚀 Custom bootloader
- ⚙️ 32-bit protected mode kernel
- 📺 VGA text mode driver
- ⌨️ PS/2 keyboard driver
- ⏱️ Timer and interrupt handling
- 📚 Basic standard library

---

## 🛠️ Requirements

- **NASM** - Assembler
- **GCC** - C Compiler
- **QEMU** - Emulator
- **Make** - Build tool

---

## 📦 Installation

**Ubuntu/Debian:**
```bash
sudo apt install nasm gcc qemu-system-x86 make
macOS:
brew install nasm i686-elf-gcc qemu make
Arch Linux:
sudo pacman -S nasm gcc qemu make

🚀 Build & Run
# Clone the repository
git clone https://github.com/yourusername/CustomOS.git
cd CustomOS

# Build the OS
make all

# Run in QEMU
make run

# Clean build files
make clean

📁 Project Structure
CustomOS/
├── 🥾 boot/           # Bootloader
├── 🧠 kernel/         # Kernel code
├── 🔌 drivers/        # VGA, keyboard, timer
├── ⚡ cpu/            # GDT, IDT, interrupts
├── 📖 libc/           # Standard library
└── 🔧 Makefile        # Build configuration

🔄 How It Works

BIOS loads the bootloader from disk
Bootloader switches to 32-bit protected mode
Kernel initializes hardware drivers
System enters main event loop


🎯 Roadmap
Completed:

 Bootloader
 Protected mode
 VGA driver
 Keyboard driver
 Timer & interrupts

In Progress:

 Memory management (paging)
 Shell with basic commands

Future:

 File system
 Process management
 Multitasking


📚 Learning Resources

📖 OSDev Wiki - OS development encyclopedia
📘 Intel Manuals - Official x86 documentation
📕 Bran's Kernel Tutorial - Beginner-friendly guide


🤝 Contributing

[!TIP]
Contributions are welcome! Feel free to:

🐛 Report bugs
💡 Suggest features
🔧 Submit pull requests
📖 Improve documentation



📄 License
This project is licensed under the MIT License - see LICENSE for details.

🙏 Acknowledgments
Thanks to the OSDev community for their incredible documentation and support.


Made with ☕ and lots of debugging
⭐ Star this repo if you find it helpful! ⭐
Report Bug · Request Feature
```
