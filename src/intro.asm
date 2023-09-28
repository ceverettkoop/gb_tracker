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

	jp Init_Scale
