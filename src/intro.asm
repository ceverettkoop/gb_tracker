INCLUDE "defines.asm"
INCLUDE "constants.asm"

SECTION "Intro", ROMX

Intro::
    ;Turn on audio
    ld a, $80
    ld [rAUDENA], a
    ; Enable all channels in stereo
    ld a, $FF
    ld [rAUDTERM], a
    ; Set volume max both channels
    ld a, $FF
    ld [rAUDVOL], a
    ;init variable default values
    xor a
    ld [note_timer], a ; note timer at zero
    dec a
    ld [note_pos], a ; pos will increment to 0 on first run
    ld a, BASE_LEN
    ld [note_len], a ;default note length
;timer init
    ld a, %00000100 
    ld [rTAC], a; timer enable and ping 4096 hz
    ld a, 41 
    ld [rTMA], a ;w module get timer to roughly 100 hz? so we should catch it as it advances 

Wait_loop:
    jr Wait_loop ;loop until interrupts called
