[bits 16]
disk_load:
    push dx
    mov ah, 0x02    ; Fonction lecture BIOS
    mov al, dh      ; Nombre de secteurs
    mov ch, 0x00    ; Cylindre 0
    mov dh, 0x00    ; Tête 0
    mov cl, 0x02    ; Secteur 2 (après boot)
    
    int 0x13        ; Interruption BIOS
    jc disk_error
    
    pop dx
    cmp dh, al      ; Vérifier secteurs lus
    jne disk_error
    ret

disk_error:
    mov bx, DISK_ERROR_MSG
    call print_string
    jmp $

DISK_ERROR_MSG db "Erreur lecture disque!", 0
