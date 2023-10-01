INCLUDE "defines.asm"

SECTION "Sound", ROMX

;play note on ch 1 based on int value in bc register (0-70 (note past C1 * 2))
; @param bc: note (0-70)
Tone:
    ;NR10 = sweep, we are ignoring
    ;NR11 = length timer and duty cycle
    ld a, %10000000 ;50% duty cycle and 0 (infinite) length timer
    ld [rNR11], a
    ;NR12 = vol and envelope
    ld a, %11110000 ;max volume no envelope
    ld [rNR12], a

    ;get note integer from b and offset 
    ld hl, Notes
    add hl, bc ;offset hl ptr by note value from loop

    ;words were loaded big endian
    ;NR13 low 8 bits of ch1 period value
    ld a, [hl]
    ld [rNR13], a

    inc hl ;move up one byte

    ;NR14 high bits
    ld a, [hl];
    or a,  %10000000;only using low 4, set high 4 to indicate on and no time limit
    and a, %10001111;set bit 6 to 0, bits 4-5 too but I think unused
    ld [rNR14], a

    ret

Done:
    rst Crash; we shouldn't be here
    
;upper and lower bytes to describe notes from C1 to C5, in just intonation
;highest 4 bits represent note A = 0, A# = 1, B = 2, C = 3, C# = 4 etc
;36 notes known (0-35)
SECTION "Note Data", ROMX
Notes:
    dw $05AE, $15CC, $25F0, $360A, $4624, $5642, $6659, $7674, $8688, $96A0, $A6B1, $B6C2 
    dw $06D7, $16E6, $26F8, $3705, $4712, $5721, $672C, $773A, $8744, $9750, $A758, $B761 
    dw $076B, $1773, $277C, $3782, $4789, $5790, $6796, $779D, $87A2, $97A8, $A7AC, $B7B0
