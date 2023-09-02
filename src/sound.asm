INCLUDE "defines.asm"

SECTION "Audio", ROMX

;loop middle c on channel 1
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

Done:
    jp Done

