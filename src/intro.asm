INCLUDE "defines.asm"

SECTION "Intro", ROMX

Intro::
    ;Turn on audio
    ld a, $80
    ldh [rAUDENA], a
    ; Enable all channels in stereo
    ld a, $FF
    ldh [rAUDTERM], a
    ; Set volume max both channels
    ld a, $FF
    ldh [rAUDVOL], a

	jr Tone
