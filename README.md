<div align="center">

# 🖥️ CustomOS  
*A minimal x86 operating system built from scratch for learning purposes*

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
![Platform](https://img.shields.io/badge/platform-x86-orange.svg)
![Made with](https://img.shields.io/badge/made%20with-C%20%7C%20ASM-green.svg)
![Lines of Code](https://img.shields.io/badge/lines%20of%20code-2000%2B-brightgreen.svg)
![Build](https://img.shields.io/badge/build-passing-success.svg)

**[Features](#-features)** • **[Installation](#-installation)** • **[Quick Start](#-quick-start)** • **[Documentation](#-project-structure)** • **[Roadmap](#-roadmap)**

</div>

---

## 💡 About

**CustomOS** is an educational operating system written in **x86 Assembly** and **C** to understand how operating systems work at a low level.

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
> “If you want to truly understand computers, build your own OS.”  
>  
> This project is my journey into systems programming — feel free to learn from it, fork it, and make it your own. 💜  

---

## ✨ Features

<table>
<tr>
<td width="50%">

### 🚀 Core
- ✅ 16-bit custom bootloader  
- ✅ 32-bit protected mode kernel  
- ✅ Global Descriptor Table (GDT)  
- ✅ Interrupt Descriptor Table (IDT)  
- ✅ ISR / IRQ handling  
- ✅ Exception handling  

</td>
<td width="50%">

### 🔌 Drivers & Libraries
- ✅ VGA text mode (80x25, 16 colors)  
- ✅ PS/2 keyboard driver  
- ✅ PIT timer (18.222 Hz)  
- ✅ libc subset (`string`, `memory`, `I/O`)  
- ✅ Screen scrolling & cursor  
- ✅ Color output  

</td>
</tr>
</table>

---

## 🛠️ Requirements

| Tool | Version | Purpose |
|------|----------|----------|
| **NASM** | 2.14+ | x86 assembler |
| **GCC** | 7.0+ | C compiler (`i686-elf` recommended) |
| **QEMU** | 4.0+ | Emulator |
| **Make** | 4.0+ | Build automation |
| **GDB** *(optional)* | 8.0+ | Debugging |

---

## 📦 Installation

<details>
<summary><b>🐧 Ubuntu / Debian</b></summary>

```bash
sudo apt update
sudo apt install nasm gcc qemu-system-x86 make binutils gdb
</details> <details> <summary><b>🍎 macOS</b></summary>
```
Copier le code
brew install nasm i686-elf-gcc qemu make i686-elf-gdb
</details> <details> <summary><b>🎯 Arch Linux</b></summary>
bash
Copier le code
sudo pacman -S nasm gcc qemu make gdb
</details> <details> <summary><b>🪟 Windows (WSL)</b></summary>
bash
Copier le code
sudo apt update
sudo apt install nasm gcc qemu-system-x86 make binutils gdb
</details>
⚡ Quick Start
bash
Copier le code
# 1️⃣ Clone the repository
git clone https://github.com/yourusername/CustomOS.git
cd CustomOS

# 2️⃣ Build the OS
make all

# 3️⃣ Run it in QEMU
make run

# 4️⃣ Debug (optional)
make debug

# 5️⃣ Clean build files
make clean
🎮 QEMU Shortcuts
Key	Action
Ctrl + Alt + G	Release mouse from QEMU
Ctrl + Alt + 1	Switch to monitor console
Ctrl + Alt + 2	Switch back to OS
Ctrl + A, X	Exit QEMU

📁 Project Structure
csharp
Copier le code
CustomOS/
├── 🥾 boot/
│   └── boot_sect.asm          # 16-bit bootloader (512 B)
│
├── 🧠 kernel/
│   ├── kernel.c               # Main kernel
│   ├── kernel_entry.asm       # 32-bit entry point
│   └── util.c                 # Helpers / libc subset
│
├── 🔌 drivers/
│   ├── ports.[ch]             # I/O operations
│   ├── screen.[ch]            # VGA driver
│   ├── keyboard.[ch]          # PS/2 driver
│   └── timer.[ch]             # PIT driver
│
├── ⚡ cpu/
│   ├── gdt.[ch|asm]           # GDT setup
│   ├── idt.[ch|asm]           # IDT setup
│   ├── isr.[ch|asm]           # Interrupts
│   └── timer.[ch]             # CPU timer config
│
├── 📖 libc/
│   ├── mem.[ch]               # memcpy, memset
│   ├── string.[ch]            # strlen, strcmp
│   └── function.h             # Utility macros
│
├── 🔧 Makefile
└── 📄 README.md
🔄 How It Works
pgsql
Copier le code
┌───────────────────────────────────────────────────────┐
│                   BOOT SEQUENCE                       │
└───────────────────────────────────────────────────────┘
💾 BIOS loads bootloader (sector 0)

🥾 Bootloader (16-bit) loads kernel, enables A20, enters Protected Mode

🧠 Kernel (32-bit) sets up GDT / IDT, drivers, interrupts

⚙️ Main Loop handles keyboard, timer, and VGA output

🎯 Roadmap
Phase	Goal	Status
🥾 Phase 1: Boot & Protected Mode	Bootloader, kernel load, GDT	✅ Done
⚙️ Phase 2: Interrupts & Drivers	IDT, ISRs, IRQs, VGA, keyboard, timer	✅ Done
💾 Phase 3: Memory Management	Paging, heap, allocator	🟡 In progress
💬 Phase 4: Shell Interface	Command interpreter, history, UI	🔜 Planned
📁 Phase 5: File System	FAT12, file ops, directories	🔜 Future
🧩 Phase 6: Multitasking	Scheduler, context switching	🔜 Future

📚 Learning Resources
📖 Must-Reads
OSDev Wiki — The OS development bible

Intel x86 Manuals

Bran’s Kernel Tutorial

🎥 Videos
Writing an OS from Scratch (YouTube series)

OSDev Series — step-by-step build guides

📘 Books
Operating Systems: Design and Implementation — A. S. Tanenbaum

Modern Operating Systems — A. S. Tanenbaum

Operating System Concepts — Silberschatz, Galvin, Gagne

🧩 Debugging (GDB)
bash
Copier le code
# Terminal 1: run QEMU in debug mode
make debug

# Terminal 2: connect GDB
gdb kernel.elf
(gdb) target remote localhost:1234
(gdb) break kernel_main
(gdb) continue
Command	Description
break kernel_main	Set breakpoint
continue	Resume execution
step / next	Step into / over
info registers	Show registers
x/16x $esp	Examine stack

🤝 Contributing
[!TIP]
Contributions are welcome — bugs, docs, or new features.

How to Contribute
bash
Copier le code
# Fork the repo
git checkout -b feature/amazing-feature
# Make changes
git commit -m "Add amazing feature"
git push origin feature/amazing-feature
# Open a Pull Request
Ideas
🐛 Fix bugs • 📝 Improve docs • ✨ Add features • 🧪 Write tests • 🎨 Enhance UI • 🌍 Translate content

📊 Stats
<div align="center">
Metric	Value
Lines of Code	~2 000 +
Files	25 +
Bootloader Size	512 bytes
Kernel Size	~50 KB
Resolution	80×25 text
Colors	16

</div>
📄 License
This project is licensed under the MIT License — see LICENSE for details.

🙏 Acknowledgments
💙 OSDev Community — invaluable documentation
🎓 Bran Kernighan — inspiration for countless devs
🔥 Linus Torvalds — proof it can be done
☕ Coffee — the real scheduler behind this project

🌟 Star History
<div align="center"> <img src="https://api.star-history.com/svg?repos=yourusername/CustomOS&type=Date" alt="Star History Chart" /> </div>
<div align="center">
💻 Made with ☕ and countless debug sessions
If this project helped you, please consider giving it a ⭐
<br><br>
Report Bug • Request Feature • Back to Top

</div> ```
