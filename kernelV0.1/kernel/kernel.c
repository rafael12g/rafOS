#include "../drivers/screen.h"
#include "../drivers/keyboard.h"
#include "../cpu/idt.h"
#include "../cpu/isr.h"
#include "../cpu/timer.h"
#include "../libc/string.h"

void kernel_main() {
    // Initialiser l'écran
    clear_screen();
    print("Bienvenue dans MyKernel v0.1\n");
    print("=============================\n\n");
    
    // Initialiser l'IDT
    isr_install();
    idt_init();
    
    print("IDT initialise\n");
    
    // Activer les interruptions
    asm volatile("sti");
    
    // Initialiser le timer (100Hz)
    init_timer(100);
    print("Timer initialise\n");
    
    // Initialiser le clavier
    init_keyboard();
    print("Clavier initialise\n\n");
    
    print("Tapez quelque chose:\n");
    print("> ");
    
    // Boucle infinie
    while(1);
}
