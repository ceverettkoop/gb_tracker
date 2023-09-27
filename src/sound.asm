INCLUDE "defines.asm"

SECTION "Audio", ROMX

Init_Notes:


Init_Scale:
    xor b, b ;init loop counter to 0

;loop through scale, 36 notes, increments by two bc note is 16 bit
Scale:
    push bc
    inc b
    inc b ;up two now
    ;check if b is 72 i.e. we are done
    ldh a, b
    cp a, 72
    jr z, Reset_Loop ;if b = 72 set b and stack value to zero
    jr Tone ;else take current value on stack to Tone

Reset_Loop:
    ;set b to zero and int on stack to zero
    pop bc
    xor b,b
    push bc
    jr Tone

;play note on ch 1 based on int value on stack (0-35)
Tone:
    ;NR10 = sweep, we are ignoring
    ;NR11 = length timer and duty cycle
    ld a, %10000000 ;50% duty cycle and 0 length timer
    ld [rNR11], a
    ;NR12 = vol and envelope
    ld a, %11110000 ;max volume no envelope
    ld [rNR12], a

    ;get note integer from stack
    pop af
    ld hl, Notes
    add hl, af ;offset hl ptr by note value from stack

    ;NR14 high bits (need to discard first 4 bits? actually need to set them to some value)
    ld a, [hl] ;TODO FIX FIRST HIGH FOUR BITS
    ld [rNR14], a

    inc hl ;move up one byte
    ;NR13 low 8 bits of ch1 period value
    ; target period is 504 which supposedly is 261 hz eg middle C
    ld a, [hl]
    ld [rNR13], a

    ;TODO WAIT FOR A SECOND HERE
    jr Scale ;to note increment loop

Done:
    jp Done ; loop forever if we get here

;upper and lower bytes to describe notes from C1 to C5, in just intonation
;highest 4 bits represent note A = 0, A# = 1, B = 2, C = 3, C# = 4 etc
;36 notes known (0-35)
SECTION "Note Data", ROMX
Notes:
    dw $05AE, $15CC, $25F0, $360A, $4624, $5642, $6659, $7674, $8688, $96A0, $A6B1, $B6C2 
    dw $06D7, $16E6, $26F8, $3705, $4712, $5721, $672C, $773A, $8744, $9750, $A758, $B761 
    dw $076B, $1773, $277C, $3782, $4789, $5790, $6796, $779D, $87A2, $97A8, $A7AC, $B7B0
