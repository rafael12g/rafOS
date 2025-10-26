#include "../drivers/screen.h"
#include "../drivers/keyboard.h"
#include "../libc/string.h"

#define MAX_INPUT 256

static char input_buffer[MAX_INPUT];
static int input_pos = 0;

void print_banner() {
    clear_screen();
    print_color("\n", CYAN_ON_BLACK);
    print_color("  ____       __  ___  _____ \n", CYAN_ON_BLACK);
    print_color(" |  _ \\ __ _ / _|/ _ \\/ ____|\n", CYAN_ON_BLACK);
    print_color(" | |_) / _` | |_| | | (___  \n", CYAN_ON_BLACK);
    print_color(" |  _ < (_| |  _| |_| |\\___ \\\n", CYAN_ON_BLACK);
    print_color(" |_| \\_\\__,_|_|  \\___/ ____) |\n", CYAN_ON_BLACK);
    print_color("                      |_____/ \n", CYAN_ON_BLACK);
    print_color("\n", WHITE_ON_BLACK);
    print_color("RafOS v1.0 - Custom Operating System\n", YELLOW_ON_BLACK);
    print_color("Type 'help' for available commands\n\n", WHITE_ON_BLACK);
}

void cmd_help() {
    print_color("\nAvailable commands:\n", YELLOW_ON_BLACK);
    print("  help    - Show this message\n");
    print("  clear   - Clear the screen\n");
    print("  echo    - Repeat your input\n");
    print("  about   - About RafOS\n");
    print("  uptime  - System information\n");
    print("  reboot  - Restart RafOS\n\n");
}

void cmd_clear() {
    print_banner();
}

void cmd_about() {
    print_color("\nRafOS - Custom Operating System\n", CYAN_ON_BLACK);
    print("Version: 1.0\n");
    print("Author: Raf\n");
    print("Built with: GCC, NASM, Python\n");
    print("Architecture: x86 (32-bit)\n\n");
}

void cmd_uptime() {
    print_color("\nSystem Information:\n", GREEN_ON_BLACK);
    print("  CPU: x86 (32-bit)\n");
    print("  Memory: 640 KB conventional\n");
    print("  Video: VGA text mode 80x25\n");
    print("  Keyboard: PS/2\n\n");
}

void cmd_reboot() {
    print_color("\nRebooting RafOS...\n", RED_ON_BLACK);
    // Attendre un peu
    for (volatile int i = 0; i < 10000000; i++);
    print_banner();
}

void process_command() {
    input_buffer[input_pos] = '\0';
    
    print("\n");
    
    if (input_pos == 0) {
        // Commande vide
    }
    else if (strcmp(input_buffer, "help") == 0) {
        cmd_help();
    }
    else if (strcmp(input_buffer, "clear") == 0) {
        cmd_clear();
    }
    else if (strcmp(input_buffer, "about") == 0) {
        cmd_about();
    }
    else if (strcmp(input_buffer, "uptime") == 0) {
        cmd_uptime();
    }
    else if (strcmp(input_buffer, "reboot") == 0) {
        cmd_reboot();
    }
    else if (strncmp(input_buffer, "echo ", 5) == 0) {
        print("  ");
        print(input_buffer + 5);
        print("\n\n");
    }
    else {
        print_color("  Unknown command: '", RED_ON_BLACK);
        print(input_buffer);
        print_color("'\n", RED_ON_BLACK);
        print("  Type 'help' for available commands\n\n");
    }
    
    input_pos = 0;
    print_color("raf@RafOS", GREEN_ON_BLACK);
    print_color(":~$ ", CYAN_ON_BLACK);
}

void kernel_main() {
    print_banner();
    init_keyboard();
    
    print_color("raf@RafOS", GREEN_ON_BLACK);
    print_color(":~$ ", CYAN_ON_BLACK);
    
    input_pos = 0;
    
    while(1) {
        if (keyboard_available()) {
            char c = keyboard_getchar();
            
            if (c == 0) continue;
            
            if (c == '\n') {
                process_command();
            }
            else if (c == '\b') {
                if (input_pos > 0) {
                    input_pos--;
                    print("\b \b");
                }
            }
            else if (c >= 32 && c <= 126) {
                if (input_pos < MAX_INPUT - 1) {
                    input_buffer[input_pos++] = c;
                    print_char(c);
                }
            }
        }
    }
}
