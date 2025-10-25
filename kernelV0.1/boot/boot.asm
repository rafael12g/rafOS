[org 0x7c00]
KERNEL_OFFSET equ 0x1000

    mov [BOOT_DRIVE], dl    ; BIOS stocke le disque de boot dans dl
    
    ; Configurer la pile
    mov bp, 0x9000
    mov sp, bp

    mov bx, MSG_REAL_MODE
    call print_string
    call load_kernel
    call switch_to_pm       ; Ne revient jamais
    jmp $

%include "boot/print_string.asm"
%include "boot/disk_load.asm"

load_kernel:
    mov bx, MSG_LOAD_KERNEL
    call print_string
    
    mov bx, KERNEL_OFFSET   ; Charger vers cette adresse
    mov dh, 20              ; Charger 20 secteurs
    mov dl, [BOOT_DRIVE]
    call disk_load
    ret

%include "boot/gdt.asm"
%include "boot/switch_to_pm.asm"

[bits 32]
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm
    
    call KERNEL_OFFSET      ; Sauter au kernel!
    jmp $

%include "boot/print_string_pm.asm"

; Variables
BOOT_DRIVE db 0
MSG_REAL_MODE db "Demarrage en mode reel 16-bit", 0
MSG_LOAD_KERNEL db "Chargement du kernel...", 0
MSG_PROT_MODE db "Mode protege 32-bit actif", 0

; Remplissage
times 510-($-$$) db 0
dw 0xaa55
