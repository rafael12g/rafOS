# rafOS

*Open-source OS under development* 🧠💾  

**rafOS** is a minimalist operating system written in Assembly and C for x86 architecture, built for **learning and experimentation** with low-level programming and OS concepts.

---

## 🧩 Table of Contents
1. [About](#about)  
2. [Features](#features)  
3. [Project Structure](#project-structure)  
4. [Requirements](#requirements)  
5. [Build & Run](#build--run)  
6. [Architecture Overview](#architecture-overview)  
7. [Contributing](#contributing)  
8. [License](#license)

---

## 🧠 About

**rafOS** is a personal educational project aiming to understand how an operating system works from the ground up — from booting, to entering protected mode, to handling hardware interrupts.  
It’s **not meant for production use**, but as a playground to explore system programming.

---

## ⚙️ Features

Current and planned features include:

- 🧭 Bootloader (16-bit real mode)
- 💽 Disk reading via BIOS interrupts
- 🚀 Switch to 32-bit protected mode
- 🧱 GDT (Global Descriptor Table) setup
- ⚡ IDT (Interrupt Descriptor Table) & ISR (Interrupt Service Routines)
- 🔔 IRQ handling & PIC remapping
- 🖥️ VGA text mode driver
- ⌨️ PS/2 keyboard driver
- ⏱️ PIT timer driver
- 🧮 Basic libc-like functions (`memcpy`, `memset`, etc.)
- 🔁 Main kernel loop after initialization

---

## 📂 Project Structure

rafOS/
├── boot/
│ ├── boot_sect.asm # Bootloader (stage 1)
│ └── kernel_entry.asm # Entry point for the kernel
├── kernel/
│ ├── kernel.c
│ ├── kernel.h
│ ├── low_level.c
│ ├── low_level.h
│ └── util.c
├── drivers/
│ ├── screen.c # VGA text driver
│ ├── screen.h
│ ├── keyboard.c # Keyboard driver
│ ├── keyboard.h
│ ├── timer.c # PIT timer driver
│ └── timer.h
├── cpu/
│ ├── gdt.c
│ ├── gdt.h
│ ├── idt.c
│ ├── idt.h
│ ├── isr.c
│ ├── isr.h
│ ├── interrupt.asm
│ └── timer.c
├── Makefile
├── README.md
└── LICENSE

markdown
Copier le code

---

## 🧰 Requirements

To build and run **rafOS**, you’ll need the following tools installed:

- **nasm** — assembler  
- **gcc** (or `i686-elf-gcc`)  
- **make**  
- **qemu-system-x86** — for emulation  

### 🐧 Linux (Debian/Ubuntu)

```bash
sudo apt update
sudo apt install nasm gcc make qemu-system-x86
🍎 macOS (Homebrew)
bash
Copier le code
brew install nasm i686-elf-gcc qemu make
🛠️ Build & Run
bash
Copier le code
# Clone the repo
git clone https://github.com/rafael12g/rafOS.git
cd rafOS

# Build
make

# Run with QEMU
make run

# Clean build files
make clean
If everything works, you should see your custom bootloader and kernel running in the QEMU emulator. 🖥️

🧱 Architecture Overview
Boot process:

BIOS → Bootloader
The BIOS loads the first 512 bytes (boot sector) to memory at 0x7C00.

Bootloader (ASM)

Enables A20 line

Loads kernel sectors into memory

Switches to 32-bit protected mode

Jumps to kernel_entry.asm

Kernel Initialization

Set up GDT & IDT

Initialize ISRs and IRQs

Enable hardware drivers (screen, keyboard, timer)

Main Loop

Kernel runs in an infinite loop waiting for interrupts or input

Future extensions: memory management, scheduler, filesystem, etc.

🤝 Contributing
Contributions and experiments are welcome!
You can:

Fork the repository

Create feature branches (feature/memory-manager, feature/filesystem, etc.)

Submit pull requests

Document your additions in comments or markdown files

📜 License
This project is licensed under the MIT License — see the LICENSE file for details.

“Building your own OS teaches you more about computers than any textbook ever could.”
