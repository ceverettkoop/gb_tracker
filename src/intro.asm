INCLUDE "defines.asm"

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

Timer_Init:
    ld a, %00000100
    ld [rIE], a ;timer interrupt enable, this should make it crash on timer event?
    ld a, %00000100 
    ld [rTAC], a; timer enable and ping 4096 hz
    ld a, 41 
    ld [rTMA], a ;w module get timer to roughly 100 hz? so we should catch it as it advances 

	jp Init_Scale
