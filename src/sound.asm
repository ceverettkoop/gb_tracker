INCLUDE "defines.asm"

SECTION "Audio", ROMX

Init_Notes:


;loop note on stack on ch 1
Tone:
    ;NR10 = sweep, we are ignoring
    ;NR11 = length timer and duty cycle
    ld a, %10000000 ;50% duty cycle and 0 length timer
    ld [rNR11], a
    ;NR12 = vol and envelope
    ld a, %11110000 ;max volume no envelope
    ld [rNR12], a

    ;NR13 low 8 bits of ch1 period value
    ; target period is 504 which supposedly is 261 hz eg middle C
    ld a, $00
    ld [rNR13], a

    ;NR14 high bits
    ld a, %10000111
    ld [rNR14], a
    $740

Done:
    jp Done

;upper and lower bytes to describe notes from C1 to C5, in just intonation
;highest 4 bits represent note A = 0, A# = 1, B = 2, C = 3, C# = 4 etc
SECTION "Note Data", ROMX
    dw $05AE, $15CC, $25F0, $360A, $4624, $5642, $6659, $7674, $8688, $96A0, $A6B1, $B6C2 
    dw $06D7, $16E6, $26F8, $3705, $4712, $5721, $672C, $773A, $8744, $9750, $A758, $B761 
    dw $076B, $1773, $277C, $3782, $4789, $5790, $6796, $779D, $87A2, $97A8, $A7AC, $B7B0
