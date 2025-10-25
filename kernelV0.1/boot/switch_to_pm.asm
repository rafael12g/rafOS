[bits 16]
switch_to_pm:
    cli                     ; Désactiver interruptions
    lgdt [gdt_descriptor]   ; Charger GDT
    
    mov eax, cr0
    or eax, 0x1             ; Activer bit mode protégé
    mov cr0, eax
    
    jmp CODE_SEG:init_pm    ; Far jump pour vider pipeline

[bits 32]
init_pm:
    mov ax, DATA_SEG        ; Mettre à jour registres segment
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    
    mov ebp, 0x90000        ; Nouvelle pile
    mov esp, ebp
    
    call BEGIN_PM
