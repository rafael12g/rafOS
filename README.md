# CustomOS

A minimal x86 operating system built from scratch for educational purposes.

> "If you want to truly understand how computers work, build your own operating system."
> 
> This project is my journey into systems programming. Feel free to learn from it, modify it, and make it your own. All I ask is that you share your knowledge with others as freely as it was shared with you.

## About

CustomOS is an educational operating system written in x86 Assembly and C. This is a learning project to understand OS fundamentals: bootloaders, protected mode, interrupts, and drivers.

## Features

- Custom 16-bit bootloader
- 32-bit protected mode kernel
- VGA text mode driver (80x25, 16 colors)
- PS/2 keyboard driver (US QWERTY)
- PIT timer driver
- Interrupt handling (ISRs and IRQs)
- Basic standard library functions

## Getting Started

### Prerequisites

```bash
# Ubuntu/Debian
sudo apt-get install nasm gcc qemu-system-x86 make

# macOS
brew install nasm i686-elf-gcc qemu make

# Arch Linux
sudo pacman -S nasm gcc qemu make
Build and Run
# Clone the repository
git clone https://github.com/yourusername/CustomOS.git
cd CustomOS

# Build the OS
make

# Run in QEMU
make run

# Clean build files
make clean
Project Structure
graph TD
    A[CustomOS] --> B[boot/]
    A --> C[kernel/]
    A --> D[drivers/]
    A --> E[cpu/]
    A --> F[libc/]
    
    B --> B1[boot_sect.asm - Bootloader 16-bit]
    
    C --> C1[kernel.c - Main kernel]
    C --> C2[kernel_entry.asm - Entry point]
    
    D --> D1[screen.c - VGA driver]
    D --> D2[keyboard.c - PS/2 keyboard]
    D --> D3[timer.c - PIT timer]
    
    E --> E1[gdt.c - Global Descriptor Table]
    E --> E2[idt.c - Interrupt Descriptor Table]
    E --> E3[isr.c - Interrupt Service Routines]
    
    F --> F1[string.c - String functions]
    F --> F2[mem.c - Memory functions]
Boot Process
sequenceDiagram
    participant BIOS
    participant Bootloader
    participant Kernel
    
    BIOS->>Bootloader: Load from disk sector 0
    Bootloader->>Bootloader: Switch to protected mode
    Bootloader->>Kernel: Load kernel from disk
    Bootloader->>Kernel: Jump to kernel entry
    Kernel->>Kernel: Setup GDT
    Kernel->>Kernel: Setup IDT
    Kernel->>Kernel: Initialize drivers
    Kernel->>Kernel: Enter main loop
How It Works

BIOS loads the bootloader (512 bytes) from disk
Bootloader loads the kernel, switches to protected mode
Kernel initializes interrupts and drivers, enters main loop

Roadmap

 Memory management (physical and virtual)
 Shell with basic commands
 Simple file system
 Process support and multitasking

Learning Resources

OSDev.org - OS development wiki
Intel Software Developer Manuals
"Operating Systems: Design and Implementation" by Andrew S. Tanenbaum

Contributing
This is a personal learning project, but contributions are welcome! Feel free to open issues or submit pull requests.
License
MIT License - see LICENSE file for details.
Contact
GitHub: @yourusername
