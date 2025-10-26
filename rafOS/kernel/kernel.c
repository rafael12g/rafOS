#include "../drivers/screen.h"
#include "../drivers/keyboard.h"
#include "../libc/string.h"
#include "../browser/browser.h"

#define INPUT_BUFFER_SIZE 256

static char input_buffer[INPUT_BUFFER_SIZE];
static int input_index = 0;

void print_banner() {
    clear_screen();
    print_color("  ____       __  ___  _____ \n", CYAN_ON_BLACK);
    print_color(" |  _ \\ __ _ / _|/ _ \\/ ____|\n", CYAN_ON_BLACK);
    print_color(" | |_) / _` | |_| | | (___  \n", CYAN_ON_BLACK);
    print_color(" |  _ < (_| |  _| |_| |\\___ \\\n", CYAN_ON_BLACK);
    print_color(" |_| \\_\\__,_|_|  \\___/ ____)_|\n", CYAN_ON_BLACK);
    print_color("                      |_____/ \n\n", CYAN_ON_BLACK);
    
    print("RafOS v1.1 - Custom Operating System with Browser\n");
    print_color("Keyboard: ", GREEN_ON_BLACK);
    print_color("OK\n", GREEN_ON_BLACK);
    print("Type 'help' for available commands\n\n");
}

void print_prompt() {
    print_color("raf", GREEN_ON_BLACK);
    print_color("@", WHITE_ON_BLACK);
    print_color("RafOS", GREEN_ON_BLACK);
    print_color(":~$ ", CYAN_ON_BLACK);
}

void cmd_help() {
    print("\n");
    print_color("Available commands:\n", YELLOW_ON_BLACK);
    print("  help      - Show this message\n");
    print("  clear     - Clear the screen\n");
    print("  echo      - Repeat your input\n");
    print("  about     - About RafOS\n");
    print("  uptime    - System information\n");
    print("  browse    - Open a web page\n");
    print("  back      - Go to previous page\n");
    print("  forward   - Go to next page\n");
    print("  home      - Go to home page\n");
    print("  reboot    - Restart RafOS\n\n");
    
    print_color("Browser usage:\n", CYAN_ON_BLACK);
    print("  browse <url>  - Navigate to URL\n");
    print("  Examples:\n");
    print("    browse http://rafos.local\n");
    print("    browse http://google.com\n");
    print("    browse http://wikipedia.org\n\n");
}

void cmd_clear() {
    print_banner();
}

void cmd_about() {
    print("\n");
    print_color("RafOS - Custom Operating System\n", CYAN_ON_BLACK);
    print("Version: 1.1 (with Browser)\n");
    print("Author: Raf\n");
    print("Built with: GCC, NASM, Python\n");
    print("Architecture: x86 (32-bit)\n");
    print("Features: Shell, Browser, Custom Kernel\n\n");
}

void cmd_uptime() {
    print("\n");
    print_color("System Information:\n", YELLOW_ON_BLACK);
    print("  CPU: x86 (32-bit)\n");
    print("  Memory: 640 KB conventional\n");
    print("  Video: VGA text mode 80x25\n");
    print("  Keyboard: PS/2\n");
    print("  Browser: RafBrowser v1.0\n\n");
}

void cmd_echo(const char* args) {
    print("  ");
    print(args);
    print("\n");
}

void cmd_reboot() {
    print_color("Rebooting RafOS...\n\n", YELLOW_ON_BLACK);
    for (volatile int i = 0; i < 10000000; i++);
    print_banner();
}

void cmd_browse(const char* url) {
    if (strlen(url) == 0) {
        print("  Usage: browse <url>\n");
        print("  Example: browse http://rafos.local\n");
    } else {
        browser_navigate(url);
    }
}

void process_command() {
    input_buffer[input_index] = '\0';
    
    if (strlen(input_buffer) == 0) {
        return;
    }
    
    print("\n");
    
    // Séparer la commande et les arguments
    char* cmd = input_buffer;
    char* args = input_buffer;
    
    while (*args && *args != ' ') args++;
    if (*args == ' ') {
        *args = '\0';
        args++;
    }
    
    // Parser les commandes
    if (strcmp(cmd, "help") == 0) {
        cmd_help();
    }
    else if (strcmp(cmd, "clear") == 0) {
        cmd_clear();
    }
    else if (strcmp(cmd, "about") == 0) {
        cmd_about();
    }
    else if (strcmp(cmd, "uptime") == 0) {
        cmd_uptime();
    }
    else if (strcmp(cmd, "echo") == 0) {
        cmd_echo(args);
    }
    else if (strcmp(cmd, "reboot") == 0) {
        cmd_reboot();
    }
    else if (strcmp(cmd, "browse") == 0) {
        cmd_browse(args);
    }
    else if (strcmp(cmd, "back") == 0) {
        browser_back();
    }
    else if (strcmp(cmd, "forward") == 0) {
        browser_forward();
    }
    else if (strcmp(cmd, "home") == 0) {
        browser_home();
    }
    else {
        print_color("Unknown command: ", RED_ON_BLACK);
        print(cmd);
        print("\n");
        print("Type 'help' for available commands\n");
    }
    
    print("\n");
}

void kernel_main() {
    // Initialisation
    clear_screen();
    print("Initializing RafOS...\n");
    print("Loading keyboard driver... ");
    
    init_keyboard();
    
    print_color("OK\n", GREEN_ON_BLACK);
    print("Loading browser... ");
    
    browser_init();
    
    print_color("OK\n\n", GREEN_ON_BLACK);
    
    // Attendre un peu
    for (volatile int i = 0; i < 5000000; i++);
    
    print_banner();
    
    input_index = 0;
    print_prompt();
    
    // Boucle principale
    while (1) {
        if (keyboard_available()) {
            char c = keyboard_getchar();
            
            if (c == '\n') {
                process_command();
                input_index = 0;
                print_prompt();
            }
            else if (c == '\b') {
                if (input_index > 0) {
                    input_index--;
                    print_char('\b');
                }
            }
            else if (c >= 32 && c <= 126) {
                if (input_index < INPUT_BUFFER_SIZE - 1) {
                    input_buffer[input_index++] = c;
                    print_char(c);
                }
            }
        }
    }
}
